import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/register_patient/register_patient_cubit.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/patient_sign_up_view_body.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';

class PatientSignUpView extends StatelessWidget {
  const PatientSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterPatientCubit(getIt.get<PatienAuthRepo>()),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: PatientSignUpViewBody()),
      ),
    );
  }
}
