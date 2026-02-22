import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/chats/a_chat/widgets/chat_bubble.dart';

class AChatView extends StatelessWidget {
  const AChatView({super.key});

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
            AssetImage('assets/images/tempphoto.png'),
      ),
      const SizedBox(width: 10),
      Text(
        'حمزة طارق',
        style: Styles.textStyle25,
      ),
    ],
  ),
),
body: ListView(
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
    );
  }
}