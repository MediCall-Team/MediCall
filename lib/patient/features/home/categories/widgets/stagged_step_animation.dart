import 'package:flutter/material.dart';

class StaggeredStepAnimation extends StatelessWidget {
  final Widget child;
  final int index; // ترتيب العنصر

  const StaggeredStepAnimation({
    super.key, 
    required this.child, 
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      // التأخير: كل عنصر يتأخر 100 ميللي ثانية عن الذي قبله
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            // القيمة تبدأ من -50 (يسار) وتنتهي عند 0 (مكانه الأصلي)
            offset: Offset(-(50 * (1 - value)), 0), 
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}