import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class CustomTextField1 extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;

  const CustomTextField1({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
  });

  @override
  State<CustomTextField1> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField1> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: priColor,
            offset: const Offset(0, 2),
            blurRadius: 1, 
            spreadRadius: 0,
          ),
        ],
      ),

      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          textAlign: TextAlign.right,
          obscureText: widget.isPassword ? obscure : false,
          style: const TextStyle(
            color: Colors.grey, 
          ),

          decoration: InputDecoration(
            labelText: widget.hintText,
            labelStyle: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
            prefixIcon: Icon(widget.prefixIcon, color: Colors.grey,size: 18,),

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
              borderSide: BorderSide(color: priColor, width: 1),
              borderRadius: BorderRadius.circular(14),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: priColor, width: 1),
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}
