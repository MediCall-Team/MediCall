import 'package:flutter/material.dart';
import 'package:grad_project/features/home/models/category_model.dart';
import 'category_container.dart'; // ⬅️ استيراد الـ CategoryContainer

class CategoriesGrid extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(int index) onCategoryTap; // ⬅️ دالة تعيد الـ index
  
  const CategoriesGrid({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    // نأخذ أول 6 عناصر فقط
    final displayedCategories = categories.take(6).toList();
    
    return Column(
      children: [
        // الصف الأول (3 عناصر)
        _buildRow(displayedCategories, 0, 3),
        const SizedBox(height: 20),
        // الصف الثاني (3 عناصر)
        _buildRow(displayedCategories, 3, 6),
      ],
    );
  }
  
  Widget _buildRow(List<CategoryModel> categories, int start, int end) {
    final rowCategories = categories.sublist(
      start, 
      end <= categories.length ? end : categories.length
    );
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: rowCategories.map((category) {
        final index = categories.indexOf(category);
        return CategoryContainer(
          categoryModel: category,
          onTap: () => onCategoryTap(start + index), // ⬅️ إرسال الـ index الصحيح
        );
      }).toList(),
    );
  }
}