
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddReviewField extends StatelessWidget {
  const AddReviewField({super.key, required this.screenWidth});
 final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF1F9FD).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 22),
          hintText: "اكتب تقييمًا...",
          hintStyle:  TextStyle(color: Colors.grey,
          fontSize: screenWidth*0.035,
          fontWeight: FontWeight.bold
          ),
          border: InputBorder.none,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset("assets/images/send.svg"),
          ),
        ),
      ),
    );
  }
}
