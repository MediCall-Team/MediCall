import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/snakbar.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/foget_passcupit/forget_password_cubit_cubit.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/foget_passcupit/forget_password_cubit_state.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/screens/ResetPasswordScreen.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/custom_button.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String email;

  const VerificationCodeScreen({super.key, required this.email});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (!mounted) return;
        if (state is ForgetPasswordSuccess) {
          String finalCode = controllers.map((c) => c.text).join();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ResetPasswordPage(email: widget.email, code: finalCode),
              // builder: (_) => BlocProvider.value(
              //   value: context.read<ForgetPasswordCubit>(),
              //   child: ResetPasswordScreen(
              //     email: widget.email,
              //     code: finalCode,
              //   ),
              // ),
            ),
          );
        }

        if (state is ForgetPasswordFailure) {
          snackBarMethod(context, state.errorMsg);
          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
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
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: TextField(
                                  controller: controllers[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  autofocus: index == 0,
                                  onChanged: (value) {
                                    if (value.isNotEmpty &&
                                        index < controllers.length - 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                    if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
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
                    ),

                    const SizedBox(height: 130),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CustomButton(
                        text: "تأكيد",
                        onPressed: () {
                          String code = controllers.map((c) => c.text).join();

                          if (code.length == 4) {
                            context.read<ForgetPasswordCubit>().verifyCode(
                              email: widget.email,
                              code: code,
                            );
                          } else {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text("من فضلك أدخل الرمز كامل"),
                            //   ),

                            // );

                            snackBarMethod(context, "من فضلك أدخل الرمز كامل");
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                    //*  الجزء ده عايز يتهندل
                    const Text(
                      'لم يصلك الرمز؟ أعد الإرسال (55)',
                      style: TextStyle(fontSize: 12, color: Color(0xFF1F3E6C)),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
