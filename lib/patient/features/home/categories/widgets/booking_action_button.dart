
import 'package:flutter/material.dart';

class BookingActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final bool hasBorder;
  final VoidCallback onTap;

  const BookingActionButton({
    super.key, 
    required this.text, 
    required this.color, 
    required this.textColor, 
    this.hasBorder = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: hasBorder ? Border.all(color: Colors.grey.shade400) : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor, 
              fontWeight: FontWeight.bold,
              fontFamily: "Tajawal",
            ),
          ),
        ),
      ),
    );
  }
}