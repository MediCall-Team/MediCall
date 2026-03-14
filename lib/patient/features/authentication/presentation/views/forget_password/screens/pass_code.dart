import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/screens/ResetPasswordScreen.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/custom_button.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
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

              const SizedBox(height: 50),

              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'أدخل رمز التحقق',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F3E6C),
                      ),
                    ),
                    const Text(
                      'تم إرسال رمز مكون من 4 أرقام إلى بريدك الإلكتروني',
                      style: TextStyle(fontSize: 12, color: Color(0xFF35AAD5)),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  counterText: '',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF35AAD5),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF35AAD5),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF35AAD5),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 130),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomButton(
                  text: "تأكيد",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'لم يصلك الرمز؟ أعد الإرسال (55)',
                style: TextStyle(fontSize: 12, color: Color(0xFF1F3E6C)),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
