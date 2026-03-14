import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/CustomTextField.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/custom_button.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/upload_image.dart';

class PatientSignUpViewBody extends StatelessWidget {
   PatientSignUpViewBody({super.key});

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
                    SizedBox(height: 24),
                
                    UploadImageButton(),
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
                    // SizedBox(height: 10),

                    // CustomTextField2(
                    //   hintText: 'الموقع',
                    //   prefixIcon: Icons.location_on,
                    // ),

                    SizedBox(height: 80),
                    CustomButton(onPressed: () {
                     if(formKey.currentState!.validate()){
                      GoRouter.of(context).push(AppRouter.kHomeView);
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