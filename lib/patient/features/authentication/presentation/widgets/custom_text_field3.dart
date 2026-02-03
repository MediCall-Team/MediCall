import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class CustomTextField3 extends StatefulWidget {
  final String hintText;
  final IconData suffixIcon;
  final Function()? onTap;
  final bool isExpanded; // متغير جديد للتحكم في الاتجاه
  
  const CustomTextField3({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    this.onTap,
    this.isExpanded = false, // قيمة افتراضية false
  });

  @override
  State<CustomTextField3> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField3> {
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
          cursorColor: kPrimaryColorB,
          textAlign: TextAlign.right,
          style: const TextStyle(color: Colors.grey),
          decoration: InputDecoration(
            labelText: widget.hintText,
            labelStyle: const TextStyle(fontSize: 18, color: Colors.grey),
            suffixIcon: Transform.rotate(
              // تدوير الأيقونة 180 درجة إذا كان isExpanded = true
              angle: widget.isExpanded ? -1.5708  : 0.0, // π راديان = 180 درجة
              child: IconButton(
                onPressed: widget.onTap,
                icon: Icon(
                  widget.suffixIcon,
                  color: Colors.grey,
                  size: 18,
                ),
              ),
            ),
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