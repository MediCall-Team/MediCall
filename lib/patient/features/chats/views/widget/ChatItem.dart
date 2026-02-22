import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/utils/app_router.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: GestureDetector(
        onTap: (){ GoRouter.of(context).push(AppRouter.kAChat);},
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/tempphoto.png'),
            ),
        
            const SizedBox(width: 12),
        
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
        
            const Text(
              '7:29pm',
              style: TextStyle(color: Colors.grey, fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }
}
