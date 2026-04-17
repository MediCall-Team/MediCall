import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final bool isFirst;
  final bool isRead;
  final bool isPending;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    required this.isFirst, required this.isRead, required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75, // جعل الفقاعة مستجيبة لحجم الشاشة
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: isMe ? 50 : 12,
            right: isMe ? 12 : 50,
            top: isFirst ? 10 : 2, // تقليل المسافة إذا كانت الرسائل متتالية
            bottom: 2,
          ),

          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isMe ? const Color(0xff35AAD5) : const Color(0xffE8E8E8),
            borderRadius: _borderRadius(),
          ),
          child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,

  mainAxisSize: MainAxisSize.min, // الكولوم أصلاً واخدها وده صح
  children: [
    Text(
      message,
      style: TextStyle(
        color: isMe ? Colors.white : Colors.black87,
        fontSize: 15,
      ),
    ),
    const SizedBox(height: 4),
    Row(
      mainAxisSize: MainAxisSize.min, // السطر ده هو "السحر" اللي هيلم العرض
      children: [
      if (isMe)
  Icon(
    isPending
        ? Icons.access_time // ⏳ لسه مبعتتش
        : (isRead ? Icons.done_all : Icons.done), // ✔ أو ✔✔
    color: isPending
        ? Colors.white70
        : (isRead ? kPrimaryColorC : Colors.white70),
    size: 16,
  ),
        const SizedBox(width: 4), // مسافة بسيطة بين الأيقونة والوقت
        Text(
          time,
          style: TextStyle(
            fontSize: 10,
            color: isMe ? Colors.white70 : Colors.black45,
          ),
        ),
      ],
    ),
  ],
),
        ),
      ),
    );
  }
BorderRadius _borderRadius() {
    if (isMe) {
      print("bubble me $isMe");
      return BorderRadius.only(
        topLeft: const Radius.circular(15),
    
        topRight: Radius.circular(isFirst ? 5: 15), 
        bottomLeft: const Radius.circular(15),
        bottomRight: const Radius.circular(15),
      );
      
    }
    
    // لرسائل الطرف الآخر (المستلمة)
    return BorderRadius.only(
   
      topLeft: Radius.circular(isFirst ? 5: 15),
      topRight: const Radius.circular(15),
      bottomLeft: const Radius.circular(15),
      bottomRight: const Radius.circular(15),
    );
  
  }
}