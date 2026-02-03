import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/screens/pass_code.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/CustomTextField.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // دعم العربية
      child: Scaffold(
        backgroundColor: Colors.white, // خلفية الشاشة بيضاء
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              /// ------------------- LOGO -------------------
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 40,
                  child: Image.asset(
                    "assets/images/medicall2(1)(1).png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 70),

              /// ------------------- TITLE -------------------
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'هل نسيت كلمة المرور؟',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F3E6C),
                      ),
                    ),
                    const Text(
                      'أدخل بريدك الإلكتروني لتغيير كلمة المرور',
                      style: TextStyle(fontSize: 12, color: Color(0xFF8ABACC)),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 40),

                    /// ------------------- EMAIL INPUT -------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomTextField2(
                        hintText: 'أدخل بريدك الإلكتروني',
                        prefixIcon: Icons.email_outlined,
                        isPassword: false, // البريد ليس Password
                      ),
                    ),

                    const SizedBox(height: 130),
                  ],
                ),
              ),

              /// ------------------- SUBTITLE -------------------

              /// ------------------- NEXT BUTTON -------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomButton(
                  text: "التالي",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerificationCodeScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
