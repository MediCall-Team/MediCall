import 'package:flutter/material.dart';
import 'package:grad_project/service_provider/features/auth/presentation/widgets/step3_view_body.dart';

class Step3View extends StatelessWidget {
  const Step3View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: Step3ViewBody()),
      );
  }
}