import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),

            // 🟦 عنوان الصفحة
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'المحادثات',
                  style: const TextStyle(
                    color: Color(0xFFF1F3D6B),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 🔍 Search Box (تم تصغير الحجم وزيادة البوردر ريديس)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 40, // ✅ صغرنا حجم البوكس
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: 'بحث',
                      hintStyle: const TextStyle(
                        color: Color(0xFFD9D9D9),
                        fontSize: 16,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFFD9D9D9),
                        size: 22,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(
                          16,
                        ), // ✅ زودنا البوردر ريديس
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: priColor, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          16,
                        ), // ✅ نفس التعديل هنا
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const ChatItem();
                },
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.shade300,
                  thickness: 0.5,
                  indent: 12,
                  endIndent: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🧩 Chat Item Widget
class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          // Avatar
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/tempphoto.png'),
          ),

          const SizedBox(width: 12),

          // Name + last message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'دكتور حمزة طارق',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF1F3D6B),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'اهلا',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Time
          const Text(
            '7:29pm',
            style: TextStyle(color: Colors.grey, fontSize: 8),
          ),
        ],
      ),
    );
  }
}
