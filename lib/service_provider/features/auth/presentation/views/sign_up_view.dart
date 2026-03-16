import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/service_provider/features/auth/presentation/widgets/sign_up_view_body.dart';
import 'package:grad_project/service_provider/features/auth/presentation/view_model/sp_register_cubit/sp_register_cubit.dart';
import 'package:grad_project/service_provider/features/auth/repo/sp_regester_repo.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpRegisterCubit(
        getIt.get<SpRegesterRepo>(),
      ),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SignUpViewBody(),
        ),
      ),
    );
  }
}