import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_bottom_sheet.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_botton2.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_text_field3.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_textfield4.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/steps.dart';
import 'package:grad_project/core/utils/app_router.dart';

class Step2View extends StatelessWidget {
  Step2View({super.key});
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          //physics: const BouncingScrollPhysics(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/medicall2(1)(1).png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 25),
                  Steps(num: 2),
                  SizedBox(height: 140),
                  CustomTextField4(
                    hintText: 'التخصص',
                    suffixIcon: Icons.arrow_forward_ios_rounded,
                    isExpanded: true,
                    controller: specialtyController,
                    onSuffixTap: () {
                      showSelectionBottomSheet(
                        context: context,
                        items: ['طب عام', 'أسنان', 'جلدية', 'أطفال', 'عظام', 'أسنان', 'جلدية', 'أطفال', 'عظام'],
                        onSelect: (value) {
                          specialtyController.text = value;
                        },
                      );
                    },
                  ),

                  SizedBox(height: 12),
                  CustomTextField4(
                    hintText: 'النوع',
                    suffixIcon: Icons.arrow_forward_ios_rounded,
                    isExpanded: true,
                    controller: genderController,
                    onSuffixTap: () {
                      showSelectionBottomSheet(
                        context: context,
                        items: ['ذكر', 'أنثى'],
                        onSelect: (value) {
                          genderController.text = value;
                        },
                      );
                    },
                  ),

                  SizedBox(height: 12),
                  CustomTextField3(
                    hintText: 'سعر الكشف (ج.م)',
                    suffixIcon: Icons.wallet,
                  ),
                  SizedBox(height: 150),
                  Row(
                    children: [
                      CustomButton2(
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        text: 'رجوع',
                      ),
                      Spacer(flex: 1),
                      CustomButton2(
                        onPressed: () {
                          GoRouter.of(context).push(AppRouter.kSign3Up);
                        },
                        text: 'التالي',
                      ),
                    ],
                  ),

                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
