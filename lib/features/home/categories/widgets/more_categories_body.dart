import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/features/home/categories/widgets/costum_search_bottom.dart';
import 'package:grad_project/features/home/models/category_model.dart';

class MoreCategoriesBody extends StatelessWidget {
  MoreCategoriesBody({super.key});

  final List<CategoryModel> categories = [
    CategoryModel(
      name: "الطب الباطني",
      icon: "assets/images/internal_medicin.png",
    ),
    CategoryModel(
      name: "العلاج الطبيعي",
      icon: "assets/images/physical.png",
    ),
    CategoryModel(
      name: "العظام",
      icon: "assets/images/bones.png",
    ),
    CategoryModel(
      name: "الجلدية",
      icon: "assets/images/skin.png",
    ),
    CategoryModel(
      name: "التمريض المنزلي",
      icon: "assets/images/nursing.png",
    ),
  
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔍 Search Button Padding
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: CostumSearchBottom(),
          ),
      
          const SizedBox(height: 20),
      
          /// 🏷️ Title
          Row(
            children: const [
               SizedBox(width: 16,),
              Text(
                'التخصصات الأكثر طلبًا',
                style: Styles.textStyle20,
              ),
             
            ],
          ),
      
          const SizedBox(height: 20),
      
          /// 📋 Categories List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                     const SizedBox(width: 24),
                    /// 🖼️ Image (مصغرة)
                    Image.asset(
                      categories[index].icon,
                      width: 36,
                      height: 36,
                      fit: BoxFit.contain,
                    ),
      
                    const SizedBox(width: 20), // 👈 مسافة بين الصورة والكلام
      
                    /// 📝 Text
                    Text(
                      categories[index].name,
                      style: Styles.textStyle15F,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
