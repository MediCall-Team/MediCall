import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final bool isFirst;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
  child: ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 280),
    child: IntrinsicWidth(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xff35AAD5) : const Color(0xffD6D9DA),
          borderRadius: _borderRadius(),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment:
                  isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 11,
                  color: isMe ? Colors.white70 : Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

  }

  BorderRadius _borderRadius() {
    // مرسلة
    if (isMe) {
      return BorderRadius.only(
        topLeft: const Radius.circular(18),
        topRight: Radius.circular(isFirst ? 18 : 4),
        bottomLeft: const Radius.circular(18),
        bottomRight: const Radius.circular(4),
      );
    }

    // مستلمة
    return BorderRadius.only(
      topRight: const Radius.circular(18),
      topLeft: Radius.circular(isFirst ? 18 : 4),
      bottomRight: const Radius.circular(18),
      bottomLeft: const Radius.circular(4),
    );
  }
}
