import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const CustomLoadingIndicator({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child, // واجهة تسجيل الدخول الأصلية
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5), // المربع الشفاف الذي يغطي الشاشة
            child: Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7), // المربع الداخلي الصغير
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Lottie.asset(
                  'assets/animation/loading/Cosmos.json', // مسار ملف الـ Lottie الخاص بك
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
      ],
    );
  }
}