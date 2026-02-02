import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';


class CustomHeaderCard extends StatelessWidget {
  const CustomHeaderCard({super.key, required this.fontSize, required this.screenWidth});

  final double fontSize;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2, // تقليل النسبة قليلاً ليعطي ارتفاعاً مناسباً
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff78C6E3),
          borderRadius: BorderRadius.circular(24),
        ),
        child: LayoutBuilder( // 👈 نستخدم LayoutBuilder لمعرفة أبعاد الكونتينة الفعلي
          builder: (context, constraints) {
            double containerHeight = constraints.maxHeight;
            double containerWidth = constraints.maxWidth;

            return Stack(
              clipBehavior: Clip.none, // للسماح للصورة بالخروج للأعلى فقط لو أردت
              children: [
                // ⬇️ تعديل الصورة: نضعها في جهة اليمين وتملأ الارتفاع
                Positioned(
                  right: -10, // إزاحة بسيطة لليمين
                  bottom: -20,  // تثبيت الصورة في الحافة السفلية تماماً
                  child: Image.asset(
                    "assets/images/doctora_plus_circule.png",
                    // نجعل ارتفاع الصورة متناسب مع ارتفاع الكونتينة
                    height: containerHeight * 1.35, // تخرج قليلاً من الأعلى
                    fit: BoxFit.contain,
                  ),
                ),

                // ⬇️ محتوى النص
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: containerWidth * 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "هل تبحث عن",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: (fontSize + 16).clamp(16, 24),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "تخصص؟",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: (fontSize + 16).clamp(16, 24),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xff4DB4DA),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            "ابدأ الآن",
                            style: TextStyle(
                              fontSize: (fontSize - 2).clamp(8, 18),
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColorC, // تأكدي من تعريف secColor
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}