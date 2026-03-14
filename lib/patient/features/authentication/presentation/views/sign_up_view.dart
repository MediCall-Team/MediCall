import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      body: SafeArea(child: SignUpViewBody()),
    );
  }
}
