import 'package:flutter/material.dart';

class SCustomRequestButton extends StatelessWidget {
  const SCustomRequestButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.textColor,
    required this.screenWidth,
    this.onTap,
  });

  final IconData icon;
  final String text;
  final Color color;
  final Color textColor;
  final double screenWidth;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(-1, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: (screenWidth * 0.03).clamp(12, 24),
                fontFamily: "Tajawal",
              ),
            ),
          ],
        ),
      ),
    );
  }
}