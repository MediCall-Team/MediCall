import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/patient_sign_up_view_body.dart';

class PatientSignUpView extends StatelessWidget {
  const PatientSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: PatientSignUpViewBody()),
      );
  }
}