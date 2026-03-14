import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/register_patient/register_patient_cubit.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/CustomTextField.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/custom_button.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/upload_image.dart';

class PatientSignUpViewBody extends StatelessWidget {
  PatientSignUpViewBody({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterPatientCubit, RegisterPatientState>(
      listener: (context, state) {
        if (state is RegisterPatientSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.msg)));

          GoRouter.of(context).push(AppRouter.kHomeView);
        }

        if (state is RegisterPatientFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
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

                        const SizedBox(height: 24),

                        UploadImageButton(),

                        const SizedBox(height: 30),

                        CustomTextField2(
                          controller: firstNameController,
                          hintText: 'الإسم الأول',
                          prefixIcon: Icons.person_outlined,
                        ),

                        const SizedBox(height: 10),

                        CustomTextField2(
                          controller: lastNameController,
                          hintText: 'الإسم الأخير',
                          prefixIcon: Icons.person_outlined,
                        ),

                        const SizedBox(height: 10),

                        CustomTextField2(
                          controller: emailController,
                          hintText: 'البريد إلكتروني',
                          prefixIcon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 10),

                        CustomTextField2(
                          controller: passwordController,
                          hintText: 'أدخل كلمة المرور',
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        const SizedBox(height: 10),

                        CustomTextField2(
                          controller: phoneController,
                          hintText: 'رقم الهاتف',
                          prefixIcon: Icons.phone_outlined,
                        ),

                        const SizedBox(height: 80),

                        state is RegisterPatientLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                text: 'التالي',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context
                                        .read<RegisterPatientCubit>()
                                        .patientRegisterMethod(
                                          firstName: firstNameController.text
                                              .trim(),
                                          lastName: lastNameController.text
                                              .trim(),
                                          email: emailController.text.trim(),
                                          password: passwordController.text
                                              .trim(),
                                          phoneNumber: phoneController.text
                                              .trim(),
                                        );
                                  }
                                },
                              ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
