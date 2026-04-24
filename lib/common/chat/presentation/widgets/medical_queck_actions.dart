import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/common/chat/patient_records/presentation/views/patient_record_view.dart';
import 'package:grad_project/common/chat/presentation/view_model/chats_list/chats_lits_cubit.dart';
import 'package:grad_project/core/utils/get_it.dart';

class MedicalQuickActions extends StatelessWidget {
  const MedicalQuickActions({
    super.key,
    required this.chatId,
    required this.isClosed,
    required this.patientId,
  });

  final int chatId;
  final bool isClosed;
  final int patientId; // ✅

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

              Navigator.pop(context);
            },
          ),

          Container(width: 1, height: 40, color: Colors.grey.shade200),

          _buildActionButton(
            icon: Icons.assignment_rounded,
            label: 'السجل المرضي',
            color: Colors.teal,
            onTap: () {
              Navigator.pop(context); // اقفل الـ bottom sheet الأول
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PatientRecordView(
                    patientId: patientId, // مرريه من الـ constructor
                  ),
                ),
              );
            },
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
