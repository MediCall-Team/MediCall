import 'package:flutter/material.dart';
import 'package:grad_project/features/home/views/mobile_home_view.dart';
import 'package:grad_project/features/home/views/tablet_home_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // ناخد عرض الشاشة
    double screenWidth = MediaQuery.of(context).size.width;

    // نحدد أي Widget نعرضه حسب العرض
    if (screenWidth > 550) {
      // لو أكبر من 500 → Tablet Layout
      return const TabletHomeView();
    } else {
      // لو أصغر أو يساوي 500 → Mobile Layout
      return  MobileHomeView();
    }
  }
}