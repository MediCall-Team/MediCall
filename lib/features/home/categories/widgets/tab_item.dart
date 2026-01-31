import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final double screenWidth;
  final double screenHeight;

  const TabItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap, required this.screenWidth, required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: (screenHeight*0.058).clamp(40, 100),
          child: Center(
            child: Text(
              title,
             
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xff9C9C9C),
                fontWeight: FontWeight.bold,
                fontSize: (screenWidth * 0.035).clamp(12, 28),
                fontFamily: "Tajawal",
              ),
            ),
          ),
        ),
      ),
    );
  }
}