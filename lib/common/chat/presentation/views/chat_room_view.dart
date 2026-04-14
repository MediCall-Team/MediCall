import 'package:flutter/material.dart';
import 'package:grad_project/common/chat/data/chats_list_model.dart';
import 'package:grad_project/common/chat/presentation/widgets/chat_room_view_body.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/styles.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key, required this.chatData});

  final ChatData chatData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
  leadingWidth: 40, // 👈 يقلل المسافة من السهم
  titleSpacing: 5,  // 👈 يقرب العنوان من السهم
  title: Row(
    children: [
      CircleAvatar(
        radius: 25,
        backgroundImage:
           NetworkImage(chatData.otherPersonImage),
      ),
      const SizedBox(width: 10),
      Text(
       chatData.otherPersonName,
        style: Styles.textStyle20.copyWith(color: AppTheme.mainContrast(context)),

      ),
    ],
  ),
),
      body: SafeArea(child: 
      ChatRoomViewBody()),
    );
  }
}