
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/utils/app_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<Offset> leftHeartAnimation;
  late Animation<Offset> rightHeartAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    leftHeartAnimation = Tween<Offset>(
      begin: const Offset(-5, 0),
      end: const Offset(-2.75, 0),
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    rightHeartAnimation = Tween<Offset>(
   begin: const Offset(5, 0), 
      end: const Offset(3, 0),
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        GoRouter.of(context).go(AppRouter.kStartNow);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // القسم العلوي: القلب الأيسر
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.10),
              child: SlideTransition(
                position: leftHeartAnimation,
                child: SizedBox(
                  width: width * 0.15,
                  child: Image.asset(
                    "assets/images/heart1.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // القسم الأوسط: اللوجو والنص
            Expanded(
              child: Center(
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: Image.asset(
                    "assets/images/Vector(1)(1).png",
                    width: width * 0.9,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // القسم السفلي: القلب الأيمن
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.10),
              child: SlideTransition(
                position: rightHeartAnimation,
                child: SizedBox(
                  width: width * 0.13,
                  child: Image.asset(
                    "assets/images/heart2.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}