import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/widgets/costum_search_bottom.dart';
import 'package:grad_project/patient/features/home/data/models/category_model.dart';

class MoreCategoriesBody extends StatefulWidget {
  const MoreCategoriesBody({super.key});

  @override
  State<MoreCategoriesBody> createState() => _MoreCategoriesBodyState();
}

class _MoreCategoriesBodyState extends State<MoreCategoriesBody> {
  final List<CategoryModel> categories = [
    CategoryModel(name: "الطب الباطني", icon: "assets/images/internal_medicin.png"),
    CategoryModel(name: "العلاج الطبيعي", icon: "assets/images/physical.png"),
    CategoryModel(name: "العظام", icon: "assets/images/bones.png"),
    CategoryModel(name: "الجلدية", icon: "assets/images/skin.png"),
    CategoryModel(name: "التمريض المنزلي", icon: "assets/images/nursing.png"),
  ];

  List<CategoryModel> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = categories; // أول ما الصفحة تفتح
  }

  void _filterCategories(String query) {
    setState(() {
      filteredCategories = categories
          .where((category) =>
              category.name.contains(query)) // بحث بالحرف أو الكلمة
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: CostumSearchBottom(
              onChanged: _filterCategories, // 👈 الربط
            ),
          ),

          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'التخصصات الأكثر طلبًا',
              style: Styles.textStyle20,
            ),
          ),

          const SizedBox(height: 20),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredCategories.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRouter.kServiceProvider,
                      extra: filteredCategories[index].name,
                    );
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 24),
                      Image.asset(
                        filteredCategories[index].icon,
                        width: 36,
                        height: 36,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        filteredCategories[index].name,
                        style: Styles.textStyle15F,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
