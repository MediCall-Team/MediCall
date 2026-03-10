
import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/styles.dart';

class CustomDetialCard extends StatelessWidget {
  const CustomDetialCard({super.key, required this.number, required this.text, required this.screenWidth});
   final String number,text;
     final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:  AppTheme.background(context),
        boxShadow: const[
          BoxShadow(
             color: Colors.black26, // لون الشادو
            blurRadius: 8,         // درجة التمويه
            spreadRadius: 0.0,       // مدى انتشار الشادو
            offset: Offset(0, 4),
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Column(
          children: [
             Text(number,style: Styles.textStyle20.copyWith(
              fontSize: (screenWidth*0.045).clamp(16, 40),
              color:   AppTheme.secondary(context)
             ),),
              Text(text , style: TextStyle(color:   AppTheme.textSecondary(context),
              fontSize: (screenWidth*0.035).clamp(12, 40),

              ),),
          ],
        ),
      ),
    );
  }
}
