import 'package:flutter/material.dart';

class CustomPhoneField extends StatelessWidget {
  final String hint;
  final IconData icon;

  const CustomPhoneField({super.key, required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 14, color: Color(0xFF1F3E6C)),
      keyboardType: TextInputType.phone,
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
      ),
    );
  }
}
