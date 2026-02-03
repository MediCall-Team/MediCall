import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/patient/features/chats/views/widget/ChatItem.dart';

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
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'المحادثات',
                  style: const TextStyle(
                    color: Color(0xFFF1F3D6B),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 40,
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
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: priColor, width: 1.5),
                        borderRadius: BorderRadius.circular(16),
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
