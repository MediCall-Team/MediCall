import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/home/data/models/category_model.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    super.key, 
    required this.categoryModel, 
    required this.onTap
  });

  final CategoryModel categoryModel;
  final VoidCallback onTap; // ⬅️ تغيير من Function إلى VoidCallback

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 85, // ⬅️ أكبر شوية
        width: 85,
        decoration: BoxDecoration(
          color: AppTheme.card(context) ,//const Color(0xffE1F2F8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child:  Image.asset(
              categoryModel.icon,
              width: 35,
              height: 35,
              fit: BoxFit.contain,
              color: AppTheme.secondary(context),
            ),
              
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                categoryModel.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Tajawal",
                  color: AppTheme.secondary(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}