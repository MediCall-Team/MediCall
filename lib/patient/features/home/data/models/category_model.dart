// category_model.dart
class CategoryModel {
  final String name;
  final String icon;
  final String? id; // ⬅️ إضافة ID للمستقبل
  
  CategoryModel({
    required this.name,
    required this.icon,
    this.id,
  });
}