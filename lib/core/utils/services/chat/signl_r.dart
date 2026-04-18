import 'dart:async';
import 'dart:developer';
import 'package:grad_project/common/chat/data/message_model.dart';
import 'package:grad_project/common/chat/presentation/view_model/chats_list/chats_lits_cubit.dart';
import 'package:grad_project/common/chat/presentation/view_model/messages_list/messages_list_cubit.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  HubConnection? _connection; 
  bool _isInitialized = false;
  bool isInChat = false;
  int? currentChatId;
  bool shouldReconnect = false;

  final List<Map<String, dynamic>> _messageQueue = [];
  bool _isProcessingQueue = false;

  /// ================= INIT =================
  Future<void> init() async {
    if (_connection?.state == HubConnectionState.Connected) return;

    shouldReconnect = true;

    _connection = HubConnectionBuilder()
        .withUrl(
          "http://medicall2026.runasp.net/chatHub",
          options: HttpConnectionOptions(
            // الحل: أضفنا ?? "" لضمان عدم إرجاع null أبداً
            accessTokenFactory: () async {
              final user = CacheHelper.getUser();
              final token = user?.token ?? "";
              log("🔑 SignalR Token Status: ${token.isNotEmpty}");
              return token;
            },
          ),
        )
        .withAutomaticReconnect()
        .build();

    _registerConnectionEvents();
    _registerListeners();

    await _startConnection();
  }

  Future<void> _startConnection() async {
    try {
      if (_connection?.state == HubConnectionState.Disconnected) {
        await _connection?.start();
        log("✅ SignalR Connected Successfully");
        _isInitialized = true;
        //  processQueue();
      }
    } catch (e) {
      log("❌ SignalR Connection failed: $e");
      _isInitialized = false;
    }
  }

  void _registerConnectionEvents() {
    _connection?.onclose(({error}) {
      log("⚠️ SignalR Disconnected: $error");
      _isInitialized = false;
      if (shouldReconnect) {
        // محاولة إعادة اتصال يدوية بسيطة إذا فشل الـ Automatic
        Future.delayed(const Duration(seconds: 5), () => _startConnection());
      }
    });

    _connection?.onreconnected(({connectionId}) {
      log("✅ SignalR Reconnected: $connectionId");
      _isInitialized = true;
        processQueue();
    });
  }

  void _registerListeners() {


    _connection?.on("ReceiveNewMessage", (data) {
      final json = _parseData(data);
      if (json == null) return;
      final message = MessageModel.fromJson(json);

      final myId = CacheHelper.getUser()?.id;
      log("message.senderId ${message.senderId} signlR , myId $myId");

      // تحديث الرسالة الأخيرة في قائمة المحادثات (سواء مبعوتة أو مستلمة)
      getIt<ChatsLitsCubit>().handleChatSummaryUpdate(
        chatId: message.chatId,
        lastMessage: message.content,
        updatedAt: message.sentAt,
        unreadCount: (isInChat && currentChatId == message.chatId) 
            ? 0 
            : 1, // لو مش فاتحة الشات نزود الـ unread (الباك هيبعت التحديث الأدق لاحقاً)
      );

      if (message.senderId ==int.parse(myId!)) {
        getIt<MessagesListCubit>().confirmLastPendingMessage(message);
      } else {
        getIt<MessagesListCubit>().addIncomingMessage(message);

        if (isInChat && currentChatId == message.chatId) {
          log("📖 Automatically marking received message as read in chat: ${message.chatId}");
          scheduleMarkAsRead(message.chatId);
          getIt<MessagesListCubit>().markAllAsReadInChat(); 
        }
      }
    });

    _connection?.on("MessageSentSuccess", (data) {
      log("🎯 Inside MessageSentSuccess Listener");
      final json = _parseData(data);
      if (json == null) {
        log("❌ Data is null in MessageSentSuccess");
        return;
      }
      final message = MessageModel.fromJson(json);

      // تحديث الرسالة الأخيرة فور نجاح الإرسال للتأكد إن القائمة بره محدثة بآخر بيانات
      getIt<ChatsLitsCubit>().handleChatSummaryUpdate(
        chatId: message.chatId,
        lastMessage: message.content,
        updatedAt: message.sentAt,
        unreadCount: 0, // بما إنها مبعوتة مني فأكيد الـ unread بالنسبة لي 0
      );

      log("📞 Calling Cubit now...");
      log("🆔 Cubit HashCode in Service: ${getIt<MessagesListCubit>().hashCode}");
      log("message.senderId ${message.senderId} signlRR");
      getIt<MessagesListCubit>().confirmLastPendingMessage(message);
    });


    _connection?.on("UpdateChatListSummary", (data) {
      log("UpdateChatListSummary");

      final json = _parseData(data);
      if (json == null) return;

      // ميثود مساعدة للقراءة بأمان (عشان الـ Capital والـ Small)
      T? read<T>(String key) {
        final lowercaseKey = key.toLowerCase();
        for (var entry in json.entries) {
          if (entry.key.toLowerCase() == lowercaseKey) return entry.value as T?;
        }
        return null;
      }

      getIt<ChatsLitsCubit>().handleChatSummaryUpdate(
        chatId: read<int>("chatId") ?? 0,
        lastMessage: read<String>("lastMessage"),
        // الباك إند باعت LastMessageDate مش updatedAt
        updatedAt: read<String>("lastMessageDate") 
        != null
            ? DateTime.parse(read<String>("lastMessageDate")!)
            : null,
        unreadCount: read<int>("unreadCount") ?? 0,
      );

       log("UpdateChatListSummaryy");

       
    });

    _connection?.on("UpdateGlobalUnreadBadge", (data) {
      final json = _parseData(data);
      if (json != null) {
        getIt<ChatsLitsCubit>().updateUnreadChatsBadge(
          json["totalChatsWithUnreadMessages"] ??
              json["TotalChatsWithUnreadMessages"],
        );
      }
    });

    _connection?.on("MessagesMarkedAsRead", (data) {
      log("MessagesMarkedAsRead");
      final json = _parseData(data);
      if (json == null) return;
      final chatId = json["chatId"] ?? json["ChatId"];
      getIt<ChatsLitsCubit>().markChatAsRead(chatId);
      if (currentChatId == chatId && isInChat) {
        getIt<MessagesListCubit>().markAllAsReadInChat();
      }
       log("MessagesMarkedAsReadd");
    });


 _connection?.on("ChatClosedEvent", (data) {
   final json = _parseData(data);
      if (json == null) return;
      final chatId = json["chatId"] ?? json["ChatId"];
  log("closed chat ${chatId}");

  getIt<ChatsLitsCubit>().updateChatStatusFromSocket(
    chatId: chatId,
    isClosed: true,
  );

});

_connection?.on("ChatOpenedEvent", (data) {
    final json = _parseData(data);
      if (json == null) return;
      final chatId = json["chatId"] ?? json["ChatId"];
 
  log("open chat ${chatId}");

  getIt<ChatsLitsCubit>().updateChatStatusFromSocket(
    chatId: chatId,
    isClosed: false,
  );
});
  }

  /// ================= ACTIONS =================

  Future<void> enterChat(int chatId) async {
    await init(); // نضمن الاتصال أولاً
    isInChat = true;
    currentChatId = chatId;
    if (_connection?.state == HubConnectionState.Connected) {
      await _connection?.invoke("EnterChat", args: [chatId]);
      log("Entered Chat: $chatId");
    }
  }

  // Future<void> leaveChat() async {
  //   if (_connection?.state == HubConnectionState.Connected) {
  //     await _connection?.invoke("LeaveChat");
  //   }
  //   isInChat = false;
  //   currentChatId = null;
  //   log("Left Chat");
  // }

Future<void> leaveChat() async {
  try {
    // 1. نفحص إذا كان الاتصال قائماً فعلاً
    if (_connection?.state == HubConnectionState.Connected) {
      // 2. نضع timeout أو نكتفي بالـ try catch لحمايتها
      await _connection?.invoke("LeaveChat");
    }
  } catch (e) {
    // 3. لو حصل خطأ (نت فصل مثلاً) بنعمل log ونكمل عادي
    // لأننا في النهاية عايزين نصفر الـ Variables المحلية
    log("⚠️ Error while invoking LeaveChat (Network issue): $e");
  } finally {
    // 4. السطرين دول لازم يتنفذوا مهما حصل (سواء الطلب نجح أو فشل)
    // عشان نضمن إن حالة التطبيق المحلية رجعت لوضعها الطبيعي
    isInChat = false;
    currentChatId = null;
    log("Left Chat (Local state cleared)");
  }
}

  Future<void> sendMessage(Map<String, dynamic> dto) async {
    // 1. لو مفيش اتصال حالياً، ضيفيها للطابور فوراً
    if (_connection?.state != HubConnectionState.Connected) {
      log("📥 No Connection: Message added to queue");
      _messageQueue.add(dto);
      _startConnection(); // محاولة استعادة الاتصال
      return;
    }

    try {
      // 2. حاولي تبعتيها، لو الـ invoke فشل لأي سبب، وديها للطابور
      await _connection?.invoke("SendMessage", args: [dto]);
      log("📤 Message sent successfully via invoke");
    } catch (e) {
      log("⚠️ Direct send failed, adding to queue: $e");
      if (!_messageQueue.contains(dto)) {
        _messageQueue.add(dto);
      }
    }
  }

  void processQueue() async {
    // لو الـ process شغالة أو مفيش اتصال أو الطابور فاضي، اخرج
    if (_isProcessingQueue || 
        _connection?.state != HubConnectionState.Connected || 
        _messageQueue.isEmpty) return;

    _isProcessingQueue = true;
    log("🔄 Queue Manager: Processing ${_messageQueue.length} messages...");

    while (_messageQueue.isNotEmpty && _connection?.state == HubConnectionState.Connected) {
      final msg = _messageQueue.first;

      try {
        // نستخدم invoke هنا عشان نستنى التأكيد قبل ما نشيلها من الـ list
        await _connection?.invoke("SendMessage", args: [msg]);
        
        _messageQueue.removeAt(0);
        log("✅ Queue: Message sent and removed. Remaining: ${_messageQueue.length}");
        
        // Delay بسيط بين كل رسالة والتانية عشان ميعملش "زحمة" على الـ socket
        await Future.delayed(const Duration(milliseconds: 100));
      } catch (e) {
        log("❌ Queue: Failed to send current item ($e). Waiting for better connection...");
        // لو فشل عنصر واحد، بنوقف الطابور كله وبنخرج عشان ميعملش Infinite Loop فاشل
        break; 
      }
    }

    _isProcessingQueue = false;
  }

  Future<void> disconnect() async {
    shouldReconnect = false;
    await _connection?.stop();
    log("🛑 SignalR Stopped Manually");
  }

  void scheduleMarkAsRead(int chatId) {
    Timer(const Duration(milliseconds: 500), () {
      if (isInChat &&
          currentChatId == chatId &&
          _connection?.state == HubConnectionState.Connected) {
        _connection?.invoke("MarkChatAsRead", args: [chatId]);
      }
    });
  }

  Map<String, dynamic>? _parseData(List<Object?>? data) {
    if (data == null || data.isEmpty) return null;
    final item = data.first;
    if (item is Map<String, dynamic>) return item;
    if (item is Map) return Map<String, dynamic>.from(item);
    return null;
  }
}

