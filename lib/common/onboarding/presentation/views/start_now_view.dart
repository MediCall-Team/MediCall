
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_botton.dart';


class StartNowView extends StatelessWidget {
  const StartNowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // اللوجو في الأعلى
            SizedBox(height: 30),
                        Container(
              height: 40, // ارتفاع أقل للحاوية حول اللوجو
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/medicall2(1)(1).png",
              //  width: 250, 
                fit: BoxFit.contain,
              ),
            ),
            // صورة الأطباء
         //   Expanded(
            Expanded(
              child: Image.asset(
                "assets/images/Doctors-bro 1 (1).png",
                fit: BoxFit.contain,
              ),
            ),
        
            // النص الرئيسي
            Align(
              alignment: AlignmentGeometry.directional(-0.5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  _buildText("MediCall مرحبا بك في "),
                  _buildText("طريقتك السهلة"),
                  _buildText("للحصول على الرعاية"),
                  _buildText("الطبية المنزلية"),
                ],
              ),
            ),
        
            SizedBox(height: 20),
        
            // النص الثانوي
            Align(
              alignment: Alignment.center,
              child: Text(
                "لنبدأ رحلتك الصحية معاً",
                style: TextStyle(
                  color: kPrimaryColorB,
                  fontSize: 14,
                  fontFamily: "Tajawal",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        
            SizedBox(height: 30),
        
            // زر البدء
            CustomButton(text:  "ابدأ الآن",onPressed: () {
               GoRouter.of(context).go(AppRouter.kOnboardingPages);
            },),
        
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: kPrimaryColorB,
          fontSize: 24,
          fontFamily: "Tajawal",
          fontWeight: FontWeight.w700,
         // height: 1.4,
        ),
      ),
    );
  }
}