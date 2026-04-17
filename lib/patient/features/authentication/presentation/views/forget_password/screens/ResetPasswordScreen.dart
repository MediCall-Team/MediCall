import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/helper/snakbar.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/cubit/reset_pass_cu_cubit.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/cubit/reset_pass_cu_state.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/CustomTextField.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/custom_button.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';

class ResetPasswordPage extends StatelessWidget {
  final String email;
  final String code;

  const ResetPasswordPage({super.key, required this.email, required this.code});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPassCuCubit(getIt.get<PatienAuthRepo>()),
      child: ResetPasswordScreen(email: email, code: code),
    );
  }
}

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String code;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    passController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPassCuCubit, ResetPassCuState>(
      listener: (context, state) {
        if (state is ResetPassCuSuccess) {
          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(SnackBar(content: Text(state.msg)));
        snackBarMethod(context, state.msg);

          context.go(AppRouter.kLoginPage);
        }
        if (state is ResetPassCuFailure) {
          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(SnackBar(content: Text(state.errorMsg)));

          snackBarMethod(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
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
                    const SizedBox(height: 70),
                    const Text(
                      'إنشاء كلمة مرور جديدة',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F3E6C),
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomTextField2(
                      controller: passController,
                      hintText: 'أدخل كلمة المرور',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField2(
                      controller: confirmController,
                      hintText: 'تأكيد كلمة المرور',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 60),
                    if (state is ResetPassCuLoading)
                      const CircularProgressIndicator(),
                    CustomButton(
                      text: "تغيير",
                      onPressed: () {
                        String pass = passController.text.trim();
                        String confirm = confirmController.text.trim();

                        if (pass.isEmpty || confirm.isEmpty) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text("من فضلك أدخل كلمة المرور"),
                          //   ),
                          // );
                          snackBarMethod(context, "من فضلك أدخل كلمة المرور");
                          return;
                        }

                        if (pass != confirm) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text("كلمة المرور غير متطابقة"),
                          //   ),
                          // );
                         snackBarMethod(context, "كلمة المرور غير متطابقة");

                          return;
                        }

                        context.read<ResetPassCuCubit>().resetPassword(
                          email: widget.email,
                          code: widget.code,
                          newPassword: pass,
                        );
                      },
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