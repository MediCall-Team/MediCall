

import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class CustomChoiceButton extends StatelessWidget {
  const CustomChoiceButton({
    super.key,
    required this.isActive,
    required this.text,
    required this.image,
  });
  final bool isActive;
  final String text, image;

  @override
  Widget build(BuildContext context) {
 
    return AspectRatio(
      aspectRatio: 2.1,
      child: Container(
      
      
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: kPrimaryColorB),
          boxShadow: [
            BoxShadow(
              color: Color(0xff35aad5).withOpacity(0.3), // لون خفيف ومناسب
              blurRadius: 5, // درجة النعومة
              //  spreadRadius: 0.009, // توسّع الظل
              offset: Offset(-1, 6), // اتجاه الظل لأسفل شوي
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          color: isActive ? kPrimaryColorB : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
          children: [
            //  SizedBox(width: 1),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: CircleAvatar(
                radius: 35, // تصغير بسيط للدائرة
                backgroundColor: isActive
                    ? const Color.fromARGB(255, 178, 219, 234)
                    : kPrimaryColorB.withValues(alpha: 0.24),
                child: Image.asset(
                  color: isActive?Colors.white:kPrimaryColorB,
                  image,
                  width: 45, // تصغير الصورة
                  height: 45,
                  fit: BoxFit.contain,
                ),
              ),
            ),
      
            Text(
              textAlign: TextAlign.center,
              text,
              style: TextStyle(
                color: isActive ? Colors.white : kPrimaryColorB,
                fontFamily: "Tajawal",
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
