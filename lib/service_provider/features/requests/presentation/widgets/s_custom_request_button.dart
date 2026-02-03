
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SCustomRequestButton extends StatelessWidget {
  const SCustomRequestButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.textColor, required this.screenWidth,
  });
  final IconData icon;
  final String text;
  final Color color;
  final Color textColor;
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // لون خفيف ومناسب
            blurRadius: 5, // درجة النعومة
            //  spreadRadius: 0.009, // توسّع الظل
            offset: Offset(-1, 4), // اتجاه الظل لأسفل شوي
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: Row(
        children: [
         // SvgPicture.asset(icon,width: screenWidth*0.03,),
         Icon(icon,color:textColor ,),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
               fontSize: (screenWidth*0.03).clamp(12, 24),
              fontFamily: "Tajawal",
            ),
          ),
        ],
      ),
    );
  }
}

