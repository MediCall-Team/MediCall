import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/foget_passcupit/forget_password_cubit_cubit.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/foget_passcupit/forget_password_cubit_state.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/screens/pass_code.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/CustomTextField.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/custom_button.dart';

class ForgetPassScreenViewBody extends StatelessWidget {
  ForgetPassScreenViewBody({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.msg)));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VerificationCodeScreen(),
            ),
          );
        }

        if (state is ForgetPasswordFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child:  Column(
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
            
                const SizedBox(height: 70),
            
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
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8ABACC),
                        ),
                        textAlign: TextAlign.left,
                      ),
            
                      const SizedBox(height: 40),
            
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: CustomTextField2(
                          controller: emailController,
                          hintText: 'أدخل بريدك الإلكتروني',
                          prefixIcon: Icons.email_outlined,
                          isPassword: false,
                        ),
                      ),
            
                      const SizedBox(height: 130),
                    ],
                  ),
                ),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: state is ForgetPasswordLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: "التالي",
                          onPressed: () {
                            context
                                .read<ForgetPasswordCubit>()
                                .forgetPassword(
                                  email: emailController.text.trim(),
                                );
                          },
                        ),
                ),
            
                const SizedBox(height: 30),
              ],
            ),
          );
        
      },
    );
  }
}
