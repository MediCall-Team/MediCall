import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/common/chat/presentation/view_model/chats_list/chats_lits_cubit.dart';

class MedicalQuickActions extends StatelessWidget {
  const MedicalQuickActions({
    super.key,
    required this.chatId,
    required this.isClosed,
  });

  final int chatId;
  final bool isClosed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: isClosed ? Icons.chat_outlined : Icons.chat_rounded,
            label: isClosed ? 'فتح الشات' : 'إغلاق الشات',
            color: Colors.blue,
            onTap: () {
              context.read<ChatsLitsCubit>().toggleChat(
                    chatId: chatId,
                    isClosed: isClosed,
                  );

              Navigator.pop(context); // يقفل الـ bottom sheet
            },
          ),

          Container(
            width: 1,
            height: 40,
            color: Colors.grey.shade200,
          ),

          _buildActionButton(
            icon: Icons.assignment_rounded,
            label: 'السجل المرضي',
            color: Colors.teal,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(label),
          ],
        ),
      ),
    );
  }
}