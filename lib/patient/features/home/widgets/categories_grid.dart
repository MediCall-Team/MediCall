import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/home/models/category_model.dart';
import 'category_container.dart';

class CategoriesGrid extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(int index) onCategoryTap;

  const CategoriesGrid({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    // نعرض أول 6 تصنيفات فقط
    final displayedCategories = categories.take(6).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // عشان داخل ScrollView
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: displayedCategories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,       // 3 في الصف
        mainAxisSpacing: 20,     // مسافة رأسية
        crossAxisSpacing: 20,    // مسافة أفقية
        childAspectRatio: 1,   // عدليها لو الكارت طويل/قصير
      ),
      itemBuilder: (context, index) {
        return CategoryContainer(
          categoryModel: displayedCategories[index],
          onTap: () => onCategoryTap(index), // 🔥 index مظبوط 100%
        );
      },
    );
  }
}
