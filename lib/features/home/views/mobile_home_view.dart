import 'package:flutter/material.dart';
import 'package:grad_project/features/home/views/home_view_body.dart';

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: HomeViewBody()),
    );
  }
}