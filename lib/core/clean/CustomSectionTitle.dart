import 'package:flutter/material.dart';

class CustomSectionTitle extends StatelessWidget {
  final String title;
  final double screenWidth;
  final Color? color;

  const CustomSectionTitle({
    super.key,
    required this.title,
    required this.screenWidth,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: screenWidth * 0.044,
        fontWeight: FontWeight.bold,
        color: color ?? const Color(0xff1F3E6C),
      ),
    );
  }
}
