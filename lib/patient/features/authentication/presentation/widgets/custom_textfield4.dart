import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class CustomTextField4 extends StatelessWidget {
  final String hintText;
  final IconData suffixIcon;
  final bool isExpanded;
  final TextEditingController controller;
  final VoidCallback? onSuffixTap;

  const CustomTextField4({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    required this.controller,
    this.onSuffixTap,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: controller,
          readOnly: true,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            labelText: hintText,
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            suffixIcon: Transform.rotate(
              angle: isExpanded ? -1.5708 : 0.0,
              child: IconButton(
                onPressed: onSuffixTap,
                icon: Icon(
                  suffixIcon,
                  color: Colors.grey,
                  size: 18,
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: priColor),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: priColor),
              borderRadius: BorderRadius.circular(16),
            ),
            floatingLabelStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
