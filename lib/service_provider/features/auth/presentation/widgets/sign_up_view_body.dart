import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/snakbar.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/CustomTextField.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/custom_button.dart';
import 'package:grad_project/service_provider/features/auth/presentation/views/step2_view.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/steps.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/upload_image.dart';
import 'package:grad_project/service_provider/features/auth/presentation/view_model/sp_register_cubit/sp_register_cubit.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? userImage;
  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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

                const SizedBox(height: 20),

                const Steps(num: 1),

                const SizedBox(height: 24),

                UploadImageButton(
                  onImageSelected: (image) {
                    userImage = image;
                  },
                ),

                const SizedBox(height: 30),

                CustomTextField2(
                  hintText: 'الإسم الأول',
                  prefixIcon: Icons.person_outlined,
                  controller: firstNameController,
                ),

                const SizedBox(height: 10),

                CustomTextField2(
                  hintText: 'الإسم الأخير',
                  prefixIcon: Icons.person_outlined,
                  controller: lastNameController,
                ),

                const SizedBox(height: 10),

                CustomTextField2(
                  hintText: 'البريد إلكتروني',
                  prefixIcon: Icons.email_outlined,
                  controller: emailController,
                ),

                const SizedBox(height: 10),

                CustomTextField2(
                  hintText: 'كلمة المرور',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: passwordController,
                ),

                const SizedBox(height: 10),

                CustomTextField2(
                  hintText: 'رقم الهاتف',
                  prefixIcon: Icons.phone_outlined,
                  controller: phoneController,
                  keyboardType: TextInputType.numberWithOptions(),
                ),

                const SizedBox(height: 80),

                CustomButton(
                  onPressed: () {
                    final isValid = formKey.currentState!.validate();

                    if (userImage == null) {
                      snackBarMethod(context, "يجب إضافة صورة");
                      return;
                    }

                    if (isValid) {
                      context.read<SpRegisterCubit>().setBasicInfo(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        phone: phoneController.text,
                        password: passwordController.text,
                        email: emailController.text,
                        image: userImage!,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<SpRegisterCubit>(),
                            child: const Step2View(),
                          ),
                        ),
                      );
                    } else {
                      // 👇 ده يخلي الفورم يعمل rebuild ويظهر الأخطاء
                      setState(() {});
                    }
                  },
                  text: 'التالي',
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
