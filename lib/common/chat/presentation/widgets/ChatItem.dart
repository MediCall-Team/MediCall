import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/common/chat/data/chats_list_model.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:intl/intl.dart'; // مكتبة تنسيق الوقت

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.chatData});

  final ChatData chatData;

  @override
  Widget build(BuildContext context) {
    // حساب أحجام متجاوبة بناءً على عرض الشاشة
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarSize = screenWidth * 0.15; // حجم الصورة 15% من عرض الشاشة
    avatarSize = avatarSize.clamp(45.0, 65.0); // حدود للحجم عشان ميبقاش صغير أوي أو كبير أوي

    return InkWell( // أفضل من GestureDetector لإعطاء تأثير ضغطة (Ripple Effect)
      onTap: () {
        GoRouter.of(context).push(AppRouter.kChatRoom, extra: chatData);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // صورة الشخص
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: chatData.otherPersonImage,
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.person, size: 30),
                placeholder: (context, url) => Shimmer(
                  child: Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // الاسم وآخر رسالة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatData.otherPersonName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // لو الاسم طويل يظهر نقط
                    style: TextStyle(
                      fontSize: screenWidth * 0.04, // حجم خط متجاوب
                      fontWeight: FontWeight.bold,
                      color: AppTheme.mainContrast(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chatData.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // الوقت وعدد الرسائل غير المقروءة (اختياري)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatDateTime(chatData.lastMessageDate),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 5),
                if (chatData.unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.blue, // أو kPrimaryColorB
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${chatData.unreadCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ميثود لتنسيق الوقت بشكل ذكي
  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      // لو النهاردة يظهر الوقت بس
      return DateFormat.jm().format(dateTime); // مثال: 1:30 PM
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else {
      // لو أقدم من كدا يظهر التاريخ
      return DateFormat.yMd().format(dateTime); // مثال: 4/14/2026
    }
  }
}