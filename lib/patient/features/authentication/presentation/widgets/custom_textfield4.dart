import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class CustomTextField4 extends StatefulWidget {
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
  State<CustomTextField4> createState() => _CustomTextField4State();
}

class _CustomTextField4State extends State<CustomTextField4> {
  final _formKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          key: _formKey,
          controller: widget.controller,
          readOnly: true,
          textAlign: TextAlign.right,
          style: const TextStyle(color: Colors.grey, fontSize: 15),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "${widget.hintText} مطلوب";
            }
            return null;
          },
          onChanged: (value) {
            // اعادة التحقق بدون setState داخل build
            _formKey.currentState?.validate();
          },
          decoration: InputDecoration(
            labelText: widget.hintText,
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            suffixIcon: Transform.rotate(
              angle: widget.isExpanded ? -1.5708 : 0.0,
              child: IconButton(
                onPressed: widget.onSuffixTap,
                icon: Icon(widget.suffixIcon, color: Colors.grey, size: 18),
              ),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: priColor),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: priColor),
              borderRadius: BorderRadius.circular(16),
            ),
            errorBorder: buildBorderError(),
            focusedErrorBorder: buildBorderError(),
            floatingLabelStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorderError() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 1.8),
      borderRadius: BorderRadius.circular(16),
    );
  }
}