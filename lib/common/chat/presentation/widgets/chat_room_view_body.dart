import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/common/chat/presentation/widgets/chat_bubble.dart';
import 'package:grad_project/common/chat/presentation/widgets/write_message.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/notification/presentation/view_model/notification_number/notification_number_cubit.dart';

class ChatRoomViewBody extends StatefulWidget {
  const ChatRoomViewBody({super.key});

  @override
  State<ChatRoomViewBody> createState() => _ChatRoomViewBodyState();
}

class _ChatRoomViewBodyState extends State<ChatRoomViewBody> {

  @override
  void initState() {
     getIt<NotificationNumberCubit>().getMyChatNotificationsNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
  children: [
    Expanded(
      child: ListView(
        children: const [
      ChatBubble(
        message: "Hii",
        time: "7:03",
        isMe: false,
        isFirst: true,
      ),
      ChatBubble(
        message: "how are you",
        time: "7:03",
        isMe: false,
        isFirst: false,
      ),
      ChatBubble(
        message: "i am fine",
        time: "7:03",
        isMe: true,
        isFirst: true,
      ),
      ChatBubble(
        message: "Nullam auctor accumsan ex. Aenean ac commodo felis Vivamus cursus libero",
        time: "7:03",
        isMe: true,
        isFirst: false,
      ),
      
        ],
      ),
    ),
    WriteMessage(),
    SizedBox(height: 30,),
  ],
);
    
  }
}