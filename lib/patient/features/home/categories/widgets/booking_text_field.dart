import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/app_theme.dart';

class BookingTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final TextEditingController controller;

  const BookingTextField({
    super.key,
    required this.hint,
    this.maxLines = 1,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      textAlign: TextAlign.right,
      cursorColor: AppTheme.brandColor(context),
      // منطق التحقق من الحقل
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "هذا الحقل مطلوب";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontFamily: "Tajawal", fontSize: 13),
        contentPadding: const EdgeInsets.all(12),
        // تعديل ألوان الحدود لتتناسب مع خطأ التحقق
        errorStyle: const TextStyle(fontFamily: "Tajawal", fontSize: 11),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xff1F3E6C), width: 0.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppTheme.brandColor(context), width: 0.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 0.8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
      ),
    );
  }
}