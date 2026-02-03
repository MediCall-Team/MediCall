
import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class BookingTextField extends StatelessWidget {
  final String hint;
  final int maxLines;

  const BookingTextField({super.key, required this.hint, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      textAlign: TextAlign.right,
      cursorColor: kPrimaryColorC,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontFamily: "Tajawal"),
        filled: true,
        fillColor: Colors.white.withOpacity(0.5),
        contentPadding: const EdgeInsets.all(12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xff1F3E6C), width: 0.8),
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: kPrimaryColorC, width: 0.8),
        ), 
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}