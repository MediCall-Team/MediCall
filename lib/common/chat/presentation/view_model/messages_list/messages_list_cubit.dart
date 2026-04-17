import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grad_project/common/chat/data/message_model.dart';
import 'package:grad_project/common/chat/repo/chat_repo.dart';
import 'package:meta/meta.dart';

part 'messages_list_state.dart';

class MessagesListCubit extends Cubit<MessagesListState> {
  MessagesListCubit(this.repo) : super(MessagesListInitial());

  final ChatRepo repo;
  List<MessageModel> allMessages = [];

  Future<void> getChatMessages({required int chatId}) async {
    emit(MessagesListLoading());

    var data = await repo.getChatMessages(chatId: chatId);
    
    data.fold(
      (failure) {
        emit(MessagesListFailure(errorMsg: failure.errorMsg));
      }, 
      (messages) {
        allMessages = messages; 
        
        emit(MessagesListSuccess(messagesList: List.from(allMessages)));
      },
    );
  }

  // ميثود إضافية ستحتاجها عند التعامل مع SignalR لإضافة رسالة واحدة فوراً
  void addLocalMessage(MessageModel newMessage) {
    allMessages.add(newMessage);
    // نرسل الحالة الجديدة بالقائمة المحدثة ليتم إعادة بناء الـ UI
    emit(MessagesListSuccess(messagesList: List.from(allMessages)));
  }

void confirmLastPendingMessage(MessageModel realMessage) {
  // بنحاول نلاقي الرسالة اللي لسه مبعوتة وحالتها Pending
  final index = allMessages.indexWhere((m) => m.isPending == true);

  if (index != -1) {
    // لو لقيناها، بنستبدلها بالرسالة الحقيقية اللي جاية من السيرفر (فيها الـ ID والوقت الصح)
    allMessages[index] = realMessage.copyWith(isPending: false);
    log("✅ Pending message confirmed and updated");
  } else {
    // لو ملقيناش رسالة Pending (مثلاً فاتحة من جهاز تاني)
    // نتأكد الأول إنها مش موجودة في القائمة قبل ما نضيفها
    final exists = allMessages.any((m) => m.id == realMessage.id);
    if (!exists) {
      allMessages.add(realMessage.copyWith(isPending: false));
      log("📱 Message added from another device");
    }
  }
  emit(MessagesListSuccess(messagesList: List.from(allMessages)));
}

void addIncomingMessage(MessageModel newMessage) {
  // نتأكد إنها مش already موجودة
  final exists = allMessages.any((m) => m.id == newMessage.id);

  if (exists) return;

  allMessages.add(newMessage);

  emit(MessagesListSuccess(messagesList: List.from(allMessages)));
}

void markAllAsReadInChat() {
  for (int i = 0; i < allMessages.length; i++) {
    allMessages[i] = allMessages[i].copyWith(isRead: true , isPending: false);
  }

  emit(MessagesListSuccess(messagesList: List.from(allMessages)));
}

}
