
import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class CustomBookButton extends StatelessWidget {
  const CustomBookButton({
    super.key,
    required this.screenWidth, required this.isActive,
  });

  final double screenWidth;
  final bool isActive;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:
        isActive?
         kPrimaryColorB
         : const Color.fromARGB(143, 115, 123, 128)
         ,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child:
          isActive?
         Text(
          "احجز الان",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: screenWidth*0.03,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
        :
         Text(
          "غير متاح",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: screenWidth*0.03,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
        ,
      ),
    );
  }
}
