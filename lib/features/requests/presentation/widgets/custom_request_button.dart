
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CustomRequestButton extends StatelessWidget {
  const CustomRequestButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.textColor,
  });
  final String icon;
  final String text;
  final Color color;
  final Color textColor;
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
          SvgPicture.asset(icon),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              // fontSize: 16,
              fontFamily: "Tajawal",
            ),
          ),
        ],
      ),
    );
  }
}

