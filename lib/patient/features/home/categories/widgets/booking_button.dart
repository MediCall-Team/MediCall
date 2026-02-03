
import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/home/categories/widgets/booking_bottom_sheet.dart';

class BookingButton extends StatelessWidget {
  const BookingButton({super.key, required this.screenWidth});
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
          showModalBottomSheet(context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
           builder:(context)=> BookingBottomSheet(screenWidth: screenWidth));

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff40B1D8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child:  Text(
              "احجز الان",
              style: TextStyle(
                fontSize:screenWidth*0.04, //20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}