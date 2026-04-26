import 'package:flutter/material.dart';

class CustomPhoneField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;

  const CustomPhoneField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
  });

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "رقم الهاتف مطلوب";
    }

    // 🇪🇬 رقم مصري
    if (!RegExp(r'^01[0125]\d{8}$').hasMatch(value)) {
      return "أدخل رقم مصري صحيح";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField( // 👈 بدل TextField
      controller: controller,
      keyboardType: TextInputType.phone,
      validator: _validatePhone, // 👈 هنا
      style: const TextStyle(fontSize: 14, color: Color(0xFF1F3E6C)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9C9C9C), fontSize: 16),
        prefixIcon: Transform.rotate(
          angle: 4.75,
          child: Icon(icon, color: const Color(0xFF9C9C9C), size: 20),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF9C9C9C)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF35AAD5), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}