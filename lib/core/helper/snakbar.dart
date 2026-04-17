import 'package:flutter/material.dart';

void snackBarMethod(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating, // 👈 يخليه floating
      backgroundColor: Colors.black.withOpacity(0.7), // 👈 شفاف
      elevation: 0, // 👈 يشيل الظل التقيل
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), // 👈 يصغره
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // 👈 حواف دائرية
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}