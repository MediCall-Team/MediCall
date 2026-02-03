import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class CustomButton2 extends StatefulWidget {
  const CustomButton2({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function()? onPressed;
  final String text;

  @override
  State<CustomButton2> createState() => _CustomButton2State();
}

class _CustomButton2State extends State<CustomButton2> {
  bool _isPressed = false; // حالة الضغط

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isPressed = !_isPressed; // تغيير الحالة عند الضغط
          });
          widget.onPressed?.call(); // استدعاء الدالة الأصلية
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isPressed ? Colors.white : priColor,
          foregroundColor: _isPressed ? priColor : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
            side: BorderSide(
              color: priColor,
              width: _isPressed ? 1.0 : 0.0,
            ),
          ),
          elevation: _isPressed ? 0 : 4,
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 17,
            fontFamily: "Tajawal",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}