import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class CustomTextField3 extends StatefulWidget {
  final String hintText;
  final IconData suffixIcon;
  final Function()? onTap;
  final bool isExpanded;
  final TextEditingController? controller; // إضافة controller
  final TextInputType? keyboardType; // إضافة نوع لوحة المفاتيح
  final String? Function(String?)? validator; // إضافة validator
  
  const CustomTextField3({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    this.onTap,
    this.isExpanded = false,
    this.controller, // controller اختياري
    this.keyboardType, // نوع لوحة المفاتيح اختياري
    this.validator, // validator اختياري
  });

  @override
  State<CustomTextField3> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField3> {
  late TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    // إذا كان هناك controller من الخارج نستخدمه، وإلا ننشئ واحد جديد
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void didUpdateWidget(CustomTextField3 oldWidget) {
    super.didUpdateWidget(oldWidget);
    // تحديث الـ controller إذا تغير من الخارج
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? TextEditingController();
    }
  }

  @override
  void dispose() {
    // نقوم بمسح الـ controller فقط إذا كنا نحن من أنشأناه
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

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
          controller: _controller,
          keyboardType: widget.keyboardType,
      //    validator: widget.validator,
          cursorColor: kPrimaryColorB,
          textAlign: TextAlign.right,
          style: const TextStyle(color: Colors.grey),
          decoration: InputDecoration(
            labelText: widget.hintText,
            labelStyle: const TextStyle(fontSize: 18, color: Colors.grey),
            suffixIcon: Transform.rotate(
              angle: widget.isExpanded ? -1.5708 : 0.0,
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