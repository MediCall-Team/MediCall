import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class CustomTextField1 extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField1({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    required this.controller,
  });

  @override
  State<CustomTextField1> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField1> {
  bool obscure = true;

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    }

    if (!widget.isPassword) {
      RegExp emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');

      if (!emailRegex.hasMatch(value)) {
        return "البريد الإلكتروني غير صحيح";
      }
    } else {
      if (value.length < 6) {
        return "كلمة المرور يجب أن تكون أكثر من 6 أحرف";
      }

      RegExp passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&-.]).+$',
      );

      if (!passwordRegex.hasMatch(value)) {
        return "كلمة المرور يجب أن تحتوي على حرف كبير وصغير ورقم ورمز";
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validateInput,
      builder: (field) {
        bool hasError = field.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: hasError ? Colors.red : priColor,
                    offset: const Offset(0, 2),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.isPassword ? obscure : false,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Colors.grey),
                  onChanged: (value) {
                    field.didChange(value);
                  },
                  decoration: InputDecoration(
                    labelText: widget.hintText,
                    labelStyle: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),

                    prefixIcon: Icon(
                      widget.prefixIcon,
                      color: Colors.grey,
                      size: 18,
                    ),

                    suffixIcon: widget.isPassword
                        ? IconButton(
                            icon: Icon(
                              obscure ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                          )
                        : null,

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: hasError ? Colors.red : priColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: hasError ? Colors.red : priColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),

            /// رسالة الخطأ خارج الـ shadow
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(right: 12, top: 6),
                child: Text(
                  field.errorText ?? "",
                  style: const TextStyle(color: Colors.red, fontSize: 11),
                  textAlign: TextAlign.right,
                ),
              ),
          ],
        );
      },
    );
  }
}
