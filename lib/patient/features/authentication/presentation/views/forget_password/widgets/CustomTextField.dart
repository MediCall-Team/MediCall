import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class CustomTextField2 extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller; // 👈 أضفنا controller

  const CustomTextField2({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller, // 👈 أضفناه هنا
  });

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: widget.controller, // 👈 هنا نربط controller
          textAlign: TextAlign.right,
          obscureText: widget.isPassword ? obscure : false,
          style: const TextStyle(color: Colors.grey),

          validator: (value) {
            if (value == null || value.isEmpty) {
              return "هذا الحقل مطلوب";
            }
            return null;
          },

          decoration: InputDecoration(
            labelText: widget.hintText,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.grey),

            prefixIcon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14159),
              child: Icon(widget.prefixIcon, color: Colors.grey, size: 24),
            ),

            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  )
                : null,

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: priColor, width: 1.2),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: priColor, width: 1.2),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
