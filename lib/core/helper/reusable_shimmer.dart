import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ReusableShimmer extends StatelessWidget {
  const ReusableShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
      color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
             color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 12, color: Colors.white),
                SizedBox(height: 6),
                Container(height: 10, width: 100, color: Colors.white),
              ],
            ),
          )
        ],
      ),
    ),
  );
  }
}