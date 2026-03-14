import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/CustomTextField.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/custom_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // لضبط اتجاه النصوص للعربية
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              /// ------------------- LOGO -------------------
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 40,
                    child: Image.asset(
                      "assets/images/medicall2(1)(1).png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 70),

              /// ------------------- TITLE -------------------
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'إنشاء كلمة مرور جديدة',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F3E6C),
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// ------------------- PASSWORD INPUT -------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomTextField2(
                        hintText: 'أدخل كلمة المرور',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// ------------------- CONFIRM PASSWORD INPUT -------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomTextField2(
                        hintText: 'تأكيد كلمة المرور',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                      ),
                    ),
                    const SizedBox(height: 130),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// ------------------- CHANGE BUTTON -------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomButton(text: "تغيير", onPressed: () {}),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
