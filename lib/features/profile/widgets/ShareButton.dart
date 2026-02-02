import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ShareButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE1F2F8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        ),
        onPressed: onPressed,
        icon: Transform.rotate(
          angle: 2.1,
          child: const Icon(
            Icons.send_rounded,
            color: Color(0xFF1F3E6C),
            size: 20,
          ),
        ),
        label: const Text(
          'مشاركة السجل ',
          style: TextStyle(
            color: Color(0xFF1F3E6C),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
