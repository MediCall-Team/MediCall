import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:grad_project/common/chat/data/chats_list_model.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/services/chat/signl_r.dart';
import 'package:grad_project/common/chat/presentation/view_model/messages_list/messages_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/common/chat/data/message_model.dart';

class WriteMessage extends StatefulWidget {
  final ChatData chatData;

  const WriteMessage({super.key, required this.chatData, });

  @override
  State<WriteMessage> createState() => _WriteMessageState();
}

class _WriteMessageState extends State<WriteMessage> {
  late var userId  ;
  @override
  void initState() {
  userId = CacheHelper.getUser()!.id;
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final cubit = context.read<MessagesListCubit>();

    /// 🔥 1. اعمل message fake
    final fakeMessage = MessageModel(
      chatId: widget.chatData.chatId,
      receiverId: widget.chatData.otherPersonId,
      id: DateTime.now().millisecondsSinceEpoch, // fake id
      content: text,
      senderId:int.parse(userId) , // مش مهم هنا لو عندك me استخدميه
      sentAt: DateTime.now(),
      isRead: false,
      isPending: true, // 👈 مهم
    );

    /// 🔥 2. ضيفها فوراً في UI
    cubit.addLocalMessage(fakeMessage);

    /// 🔥 3. ابعت للباك
    getIt<SignalRService>().sendMessage({
      "chatId": widget.chatData.chatId,
      "content": text,
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: priColor,
            child: IconButton(
              icon: Transform.rotate(
                angle: 3 * math.pi / 4,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              onPressed: _sendMessage,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: _controller,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك...',
                hintStyle: const TextStyle(color: Color(0xff9C9C9C)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff9C9C9C)),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff9C9C9C), width: 1.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: const Color(0xffF5F7F7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}