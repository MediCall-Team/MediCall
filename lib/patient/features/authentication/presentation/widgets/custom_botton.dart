import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text});

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: priColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: "Tajawal",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
