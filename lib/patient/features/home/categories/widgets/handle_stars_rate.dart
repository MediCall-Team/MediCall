import 'package:flutter/material.dart';

class StarsRate extends StatelessWidget {
  const StarsRate({
    super.key,
    required this.rate,
    required this.screenWidth,
  });

  final double rate;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index + 1 <= rate) {
          return Icon(
            Icons.star,
            color: Color(0xffFFD33C),
            size: screenWidth*0.044,
          );
        } else if (index < rate) {
          return Icon(
            Icons.star_half,
            color: Color(0xffFFD33C),
            size: screenWidth*0.044,
          );
        } else {
          return Icon(
            Icons.star_border,
            color: Color(0xffFFD33C),
            size: screenWidth*0.044,
          );
        }
      }),
    );
  }
}
