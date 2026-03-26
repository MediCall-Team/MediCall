import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/login/login_cubit.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_botton.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_loading_indecator.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_text_field1.dart';
import 'package:grad_project/core/utils/app_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController email, password;

  bool Loading = false;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoadingIndicator(
      isLoading: context.watch<LoginCubit>().loading,

      child: SingleChildScrollView(
        //physics: const BouncingScrollPhysics(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  // setState(() {
                  //   Loading = false;
                  // });
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("مرحبا بك")));
                  if(state.userModel.role=="Patient"){
                  GoRouter.of(context).go(AppRouter.kBottomNavPage);}
                  else{
                    GoRouter.of(context).go(AppRouter.kSCustomBottomNavPage);
                  }

                } else if (state is LoginFailure) {
                //  setState(() {
                //     Loading = false;
                //   }); 

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                }
              },
              builder: (context, state) {
                return Form(
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

                      CustomTextField1(
                        controller: email,
                        hintText: 'البريد الالكتروني',
                        prefixIcon: Icons.email_outlined,
                      ),

                      const SizedBox(height: 30),

                      CustomTextField1(
                        controller: password,
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
                          if (formKey.currentState!.validate()) {

                            // setState(() {
                            //   Loading = true;
                            // });

                            BlocProvider.of<LoginCubit>(context).loginMethod(
                              email: email.text,
                              password: password.text,
                            );
                            //  GoRouter.of(context).push(AppRouter.kBottomNavPage);
                          }
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
