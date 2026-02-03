
import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/common/onboarding/presentation/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: 
      Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end:Alignment.bottomCenter ,
          colors: [
          kPrimaryColorB,
          kPrimaryColorA,
        ])
      ),
        child: SafeArea(
          child: SplashViewBody(
          ),
        ),
      )
      );
  }
}