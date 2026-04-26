import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

enum FieldType { email, password, phone, normal }

class CustomTextField2 extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FieldType fieldType;

  const CustomTextField2({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    required this.controller,
    this.keyboardType,
    this.fieldType = FieldType.normal,
  });

  @override
  State<CustomTextField2> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField2> {
  bool obscure = true;

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "${widget.hintText} مطلوب";
    }

    switch (widget.fieldType) {
      case FieldType.email:
        if (!RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$')
            .hasMatch(value)) {
          return "أدخل بريد إلكتروني صحيح";
        }
        break;

      case FieldType.password:
        if (value.length < 6) {
          return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
        }

        if (!RegExp(
        //  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*_?&#-]).+$',
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*_?&#\-.]).+$'
        ).hasMatch(value)) {
          return "يجب أن تحتوي على حرف كبير وصغير ورقم ورمز";
        }
        break;

      case FieldType.phone:
        if (!RegExp(r'^01[0125]\d{8}$').hasMatch(value)) {
          return "أدخل رقم هاتف صحيح";
        }
        break;

      case FieldType.normal:
        break;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                keyboardType: widget.keyboardType,
                controller: widget.controller,
                validator: (value) => validate(value),
                cursorColor: kPrimaryColorB,
                textAlign: TextAlign.right,
                obscureText: widget.isPassword ? obscure : false,
                maxLines: 1,
                style: const TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                  labelText: widget.hintText,
                  labelStyle:
                      const TextStyle(fontSize: 15, color: Colors.grey),
                  errorMaxLines: 3,

                  prefixIcon: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159),
                    child: Icon(
                      widget.prefixIcon,
                      color: Colors.grey,
                      size: 24,
                    ),
                  ),

                  suffixIcon: widget.isPassword
                      ? IconButton(
                          icon: Icon(
                            obscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () =>
                              setState(() => obscure = !obscure),
                        )
                      : null,

                  enabledBorder: buildBorder(),
                  focusedBorder: buildBorder(),
                  border: buildBorder(),
                  errorBorder: buildBorderError(),
                  focusedErrorBorder: buildBorderError(),

                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: priColor, width: 1.2),
      borderRadius: BorderRadius.circular(16),
    );
  }

  OutlineInputBorder buildBorderError() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.8),
      borderRadius: BorderRadius.circular(16),
    );
  }
}