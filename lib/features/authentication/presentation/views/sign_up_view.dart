import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/features/authentication/presentation/widgets/custom_botton.dart';
import 'package:grad_project/features/authentication/presentation/widgets/custom_text_field2.dart';
import 'package:grad_project/features/authentication/presentation/widgets/steps.dart';
import 'package:grad_project/features/authentication/presentation/widgets/upload_image.dart';
import 'package:grad_project/core/utils/app_router.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final GlobalKey<FormState> formKey = GlobalKey();
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
              child: Form(
                key: formKey,
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
                    SizedBox(height: 20),
                    Steps(num: 1),
                    SizedBox(height: 24),
                
                    UploadImageButton(onTap: () {}),
                    SizedBox(height: 30),
                
                    CustomTextField2(
                      hintText: 'الإسم الأول',
                      prefixIcon: Icons.person_outlined,
                    ),
                    SizedBox(height: 10),
                    CustomTextField2(
                      hintText: 'الإسم الأخير',
                      prefixIcon: Icons.person_outlined,
                    ),
                    SizedBox(height: 10),
                    CustomTextField2(
                      hintText: 'البريد إلكتروني',
                      prefixIcon: Icons.email_outlined,
                    ),
                    SizedBox(height: 10),
                    CustomTextField2(
                      hintText: 'أدخل كلمة المرور',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),
                     SizedBox(height: 10),
                    CustomTextField2(
                      hintText: 'رقم الهاتف',
                      prefixIcon: Icons.phone_outlined,
                    ),
                    SizedBox(height: 10),
                    CustomTextField2(
                      hintText: 'الموقع',
                      prefixIcon: Icons.location_on,
                    ),
                    SizedBox(height: 100),
                    CustomButton(onPressed: () {
                     if(formKey.currentState!.validate()){
                      GoRouter.of(context).push(AppRouter.kSign2Up);
                     }
                    }, text: 'التالي'),
                     SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
