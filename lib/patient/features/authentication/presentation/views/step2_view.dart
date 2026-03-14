import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/step2_view_body.dart';

class Step2View extends StatelessWidget {
  const Step2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: Step2ViewBody()),
      );
  }
}