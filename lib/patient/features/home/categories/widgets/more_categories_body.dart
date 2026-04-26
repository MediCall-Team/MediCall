import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/widgets/costum_search_bottom.dart';
import 'package:grad_project/patient/features/home/data/models/category_model.dart';

class MoreCategoriesBody extends StatefulWidget {
  const MoreCategoriesBody({super.key});

  @override
  State<MoreCategoriesBody> createState() => _MoreCategoriesBodyState();
}

class _MoreCategoriesBodyState extends State<MoreCategoriesBody> {
  // final List<CategoryModel> categories = [
  //   CategoryModel(name: "الطب الباطني", icon: "assets/images/internal_medicin.png"),
  //   CategoryModel(name: "العلاج الطبيعي", icon: "assets/images/physical.png"),
  //   CategoryModel(name: "العظام", icon: "assets/images/bones.png"),
  //   CategoryModel(name: "الجلدية", icon: "assets/images/skin.png"),
  //   CategoryModel(name: "التمريض المنزلي", icon: "assets/images/nursing.png"),
  // ];

  List<CategoryModel> filteredCategories = [];
// داخل initState
@override
void initState() {
  super.initState();
  // تحويل القائمة لـ Map عشان نقدر نفلتر بالـ Index الأصلي (5)
  filteredCategories = categoriesList
      .asMap()
      .entries
      .where((entry) => entry.key != 5) 
      .map((entry) => entry.value)
      .toList();
}

// داخل ميثود البحث _filterCategories
void _filterCategories(String query) {
  setState(() {
    filteredCategories = categoriesList
        .asMap()
        .entries
        .where((entry) => 
            entry.key != 5 && // استبعاد العنصر الخامس دائمًا
            entry.value.name.contains(query)) 
        .map((entry) => entry.value)
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CostumSearchBottom(
              onChanged: _filterCategories, // 👈 الربط
            ),
          ),

          const SizedBox(height: 20),

           Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'التخصصات الأكثر طلبًا',
              style: Styles.textStyle20.copyWith(
                color: AppTheme.mainContrast(context)
              ),
            ),
          ),

          const SizedBox(height: 20),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredCategories.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              
              return GestureDetector(
                onTap: (){
                     GoRouter.of(context).push(
                      AppRouter.kServiceProvider,
                      extra: filteredCategories[index].name,
                    );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        const SizedBox(width: 24),
                        Image.asset(
                          filteredCategories[index].icon,
                          color: AppTheme.brandColor(context),
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          filteredCategories[index].name,
                          style: Styles.textStyle15F.copyWith(
                            color: AppTheme.mainContrast(context)
                          )
                          ,
                        ),
                      ],
                    ),
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
