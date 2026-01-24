import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomHeaderCard extends StatelessWidget {
  const CustomHeaderCard({super.key, required this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff78C6E3),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Positioned واحد للدائرة + الصورة
            Positioned(
              right: -30,
              top: -92,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // الدايرة نازلة لتحت شوية
                  Transform.translate(
                    offset: const Offset(0, 30), // عدلي الرقم براحتك
                    child: Image.asset(
                      'assets/images/circle.png',
                      width: 220,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // الدكتورة ثابتة
                  Image.asset(
                    "assets/images/doctora.png",
                    width: 290,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),

            // النص والمحتوى
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "هل تبحث عن",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: fontSize + 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "  تخصص؟",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: fontSize + 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff4DB4DA),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      "ابدأ الآن",
                      style: TextStyle(
                        fontSize: fontSize - 4,
                        fontWeight: FontWeight.bold,
                        color: secColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
