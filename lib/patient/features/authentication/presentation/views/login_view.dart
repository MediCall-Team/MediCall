import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/login/login_cubit.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/login_view_body.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt<PatienAuthRepo>()),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: LoginViewBody()),
      ),
    );
  }
}
