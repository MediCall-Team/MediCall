import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/features/authentication/presentation/widgets/custom_botton.dart';
import 'package:grad_project/features/authentication/presentation/widgets/custom_text_field1.dart';
import 'package:grad_project/core/utils/app_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
            
                  const SizedBox(height: 30),
            
                  Text(
                    "! مرحبًا بعودتك ",
                    style: TextStyle(
                      color: secColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                    ),
                  ),
            
                  const SizedBox(height: 100),
            
                  const CustomTextField1(
                    hintText: 'البريد الالكتروني',
                    prefixIcon: Icons.email_outlined,
                  ),
            
                  const SizedBox(height: 30),
            
                  const CustomTextField1(
                    hintText: 'أدخل كلمة المرور',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                  ),
            
                  const SizedBox(height: 10),
            
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.forgetpass);
                        },
                        child: Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyle(
                            color: secColor,
                            fontSize: 12,
                            fontFamily: "Inter",
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                    ],
                  ),
            
                  const SizedBox(height: 100),
            
                  CustomButton(
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kBottomNavPage);
                    },
                    text: 'تسجيل الدخول',
                  ),
            
                  const SizedBox(height: 25),
            
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.kChoicePage);
                        },
                        child: Text(
                          ' أنشئ حسابًا',
                          style: TextStyle(color: secColor, fontSize: 15),
                        ),
                      ),
                      Text(
                        'ليس لديك حساب؟',
                        style: TextStyle(color: priColor, fontSize: 13),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}