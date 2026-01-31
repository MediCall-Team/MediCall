import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class LocationChip extends StatelessWidget {
  final String placeName;
  final double screenWidth;
  const LocationChip({super.key, required this.placeName, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
      color: Colors.white, // لون خفيف للخلفية
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kPrimaryColorB, width: 1),
      ),
      child: Text(
        placeName,
        style:  TextStyle(
          color: kPrimaryColorC,
          fontWeight: FontWeight.bold,
          fontFamily: "Tajawal",
          fontSize: (screenWidth*0.035).clamp(12, 30),
        ),
      ),
    );
  }
}