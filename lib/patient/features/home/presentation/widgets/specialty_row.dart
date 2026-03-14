

import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_theme.dart';

class SpecialtyRow extends StatelessWidget {
  const SpecialtyRow({
    super.key,
    required this.fontSize,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
    
          Text(
            "التخصصات",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: (fontSize + 10).clamp(12, 25),
              fontWeight: FontWeight.bold,
              color: AppTheme.secondary(context),

            ),
          ),
        ],
      ),
    );
  }
}
