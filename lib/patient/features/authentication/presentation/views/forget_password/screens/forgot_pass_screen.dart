import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/foget_passcupit/forget_password_cubit_cubit.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/widgets/forget_pass_screen_view_body.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(getIt<PatienAuthRepo>()),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: ForgetPassScreenViewBody()),
      ),
    );
  }
}
