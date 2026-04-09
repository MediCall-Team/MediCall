import 'package:flutter/material.dart';

class NumberInputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextEditingController controller;

  const NumberInputField({
    super.key,
    required this.icon,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 14, color: Color(0xFF1F3E6C)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9C9C9C), fontSize: 13),
        suffixIcon: Icon(icon, color: const Color(0xFF9C9C9C), size: 18),
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF9C9C9C)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF35AAD5), width: 1.5),
        ),
      ),
    );
  }
}
