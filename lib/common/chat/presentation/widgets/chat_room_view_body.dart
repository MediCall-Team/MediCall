import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/common/chat/presentation/view_model/chats_list/chats_lits_cubit.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/services/chat/signl_r.dart';
import 'package:grad_project/patient/features/authentication/data/patient_user_model.dart';
import 'package:intl/intl.dart';
import 'package:grad_project/common/chat/data/chats_list_model.dart';
import 'package:grad_project/common/chat/presentation/view_model/messages_list/messages_list_cubit.dart';
import 'package:grad_project/common/chat/presentation/widgets/chat_bubble.dart';
import 'package:grad_project/common/chat/presentation/widgets/write_message.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/notification/presentation/view_model/notification_number/notification_number_cubit.dart';

class ChatRoomViewBody extends StatefulWidget {
  const ChatRoomViewBody({super.key, required this.chatData});

  final ChatData chatData;
  @override
  State<ChatRoomViewBody> createState() => _ChatRoomViewBodyState();
}

class _ChatRoomViewBodyState extends State<ChatRoomViewBody> {
  // تعريف الـ ScrollController
  final ScrollController _scrollController = ScrollController();
  late PatientUserModel me;
  @override
  void initState() {
    // getIt<SignalRService>().enterChat(widget.chatData.chatId);
    // getIt<SignalRService>().isInChat = true;
    // getIt<SignalRService>().currentChatId = widget.chatData.chatId;
    getIt<SignalRService>().scheduleMarkAsRead(widget.chatData.chatId);

    getIt<SignalRService>().enterChat(widget.chatData.chatId);

    BlocProvider.of<MessagesListCubit>(
      context,
    ).getChatMessages(chatId: widget.chatData.chatId);

  Future.delayed(Duration(seconds: 1),(){
    getIt<NotificationNumberCubit>().getMyChatNotificationsNumber();
  });
  
   // getIt<NotificationNumberCubit>().getMyChatNotificationsNumber();

    me = CacheHelper.getUser()!;
    super.initState();
  }

  // دالة لتحريك القائمة لآخر رسالة
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    getIt<SignalRService>().leaveChat();
    _scrollController.dispose(); // تنظيف الـ controller عند الخروج
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(
      "🆔 Cubit HashCode in UI: ${context.read<MessagesListCubit>().hashCode}",
    );

    return Column(
      children: [
        Expanded(
          child: BlocBuilder<MessagesListCubit, MessagesListState>(
            builder: (context, state) {
              if (state is MessagesListSuccess) {
                // نادِ بدالة الـ scroll كلما نجح تحميل الرسائل أو زادت رسالة
                _scrollToBottom();

                return ListView.builder(
                  controller: _scrollController, // ربط الـ controller
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: state.messagesList.length,
                  itemBuilder: (context, index) {
                    final message = state.messagesList[index];

                    // if (index > 0) {
                    //   print("INDEX: $index");
                    //   print("current: ${message.senderId}");
                    //   print(
                    //     "previous: ${state.messagesList[index - 1].senderId}",
                    //   );
                    //   print("me.id ${me.id}");
                    // }

                    bool showDateSeparator = false;
                    if (index == 0) {
                      showDateSeparator = true;
                    } else {
                      final DateTime current = state.messagesList[index].sentAt;
                      final DateTime previous =
                          state.messagesList[index - 1].sentAt;

                      // المقارنة الصحيحة: نتحقق من اليوم والشهر والسنة
                      if (current.year != previous.year ||
                          current.month != previous.month ||
                          current.day != previous.day) {
                        showDateSeparator = true;
                      }
                    }

                    return Column(
                      children: [
                        if (showDateSeparator)
                          _buildDateSeparator(message.sentAt),
                        ChatBubble(
                          message: message.content,
                          time: DateFormat('hh:mm a').format(message.sentAt),
                          isMe: message.senderId == int.parse(me.id),
                          isFirst:
                              index == 0 ||
                              state.messagesList[index - 1].senderId !=
                                  message.senderId,
                          isRead: message.isRead,
                          isPending: message.isPending,
                        ),
                      ],
                    );
                  },
                );
              } else if (state is MessagesListFailure) {
                return Center(child: Text(state.errorMsg));
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.brandColor(context),
                  ),
                );
              }
            },
          ),
        ),
        // BlocBuilder<ChatsLitsCubit, ChatsLitsState>(
        //   builder: (context, state) {
        //     if (state is! ChatsLitsSuccess) {
        //       return WriteMessage(chatData: widget.chatData);
        //     }

        //     final chat = state.chatsList.firstWhere(
        //       (c) => c.chatId == widget.chatData.chatId,
        //       orElse: () => widget.chatData,
        //     );

        //     final isClosed = chat.isClosed;

        //     if (isClosed) {
        //       return Container(
        //         width: double.infinity,
        //         padding: const EdgeInsets.all(16),
        //         margin: const EdgeInsets.symmetric(horizontal: 12),
        //         decoration: BoxDecoration(
        //           color: Colors.red.withOpacity(0.08),
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         child: const Center(
        //           child: Text(
        //             "تم إغلاق المحادثة",
        //             style: TextStyle(color: Colors.red),
        //           ),
        //         ),
        //       );
        //     }

        //     return WriteMessage(chatData: widget.chatData);
        //   },
        // ),

        BlocBuilder<ChatsLitsCubit, ChatsLitsState>(
          builder: (context, state) {
            // 1. القيمة المبدئية هناخدها من الـ widget (عشان أول ما نفتح الشاشة)
            bool isClosedLocal = widget.chatData.isClosed;

            // 2. لو الـ Cubit عنده بيانات ناجحة، هندور فيها على الحالة "اللحظية"
            if (state is ChatsLitsSuccess) {
              final index = state.chatsList.indexWhere(
                (c) => c.chatId == widget.chatData.chatId,
              );
              
              // لو لقينا الشات في القائمة، ناخد القيمة منه (لأنه هو اللي اتحدث من الـ Socket)
              if (index != -1) {
                isClosedLocal = state.chatsList[index].isClosed;
              }
            }

            // 3. بناء الـ UI بناءً على النتيجة النهائية
            if (isClosedLocal) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "تم إغلاق المحادثة",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }

            // لو مش مغلقة، يظهر مربع الكتابة عادي
            return WriteMessage(chatData: widget.chatData);
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDateSeparator(DateTime date) {
    String label;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today)
      label = "Today";
    else if (messageDate == yesterday)
      label = "Yesterday";
    else
      label = DateFormat('MMMM d, y').format(date);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
