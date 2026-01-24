import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/features/home/models/category_model.dart';
import 'package:grad_project/features/home/models/doctor_model.dart';
import 'package:grad_project/features/home/widgets/categories_grid.dart';
import 'package:grad_project/features/home/widgets/custom_doctor_card.dart';
import 'package:grad_project/features/home/widgets/custom_header_card.dart';
import 'package:grad_project/features/home/widgets/header.dart';
import 'package:grad_project/features/home/widgets/specialty_row.dart';

class HomeView extends StatelessWidget {
   HomeView({super.key});
   final List<CategoryModel> categories = [
    CategoryModel(
      name: "الطب الباطني",
      icon: "assets/images/internalMedicin.png",
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
    CategoryModel(
      name: "المزيد",
        icon: "assets/images/Plus.png",
    ),
    // يمكن إضافة المزيد...
  ];
      List<DoctorModel> doctorModelList = [
      DoctorModel(
        image: "assets/images/tempphoto.png",
        name: "حمزة طارق",
        specialty: "استشاري جراحة",
        rate: "4.9",
        price: "120",
        isActive: true
      ),
      DoctorModel(
        image: "assets/images/tempphoto.png",
        name: "حمزة طارق",
        specialty: "استشاري جراحة",
        rate: "4.9",
        price: "120",
        isActive: true
      ),
      DoctorModel(
        image: "assets/images/tempphoto.png",
        name: "حمزة طارق",
        specialty: "استشاري جراحة",
        rate: "4.9",
        price: "120",
        isActive: true
      ),
    ];



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double iconSize = width * 0.065;
    double fontSize = width * 0.04;

    return Scaffold(
      backgroundColor: Colors.white,
      body:  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 24),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: Header(fontSize: fontSize, iconSize: iconSize),
          ),

          SliverToBoxAdapter(child: SizedBox(height:50)),
          SliverToBoxAdapter(child: CustomHeaderCard(fontSize: fontSize)),
          SliverToBoxAdapter(child: SizedBox(height: 18)),
          SliverToBoxAdapter(child: SpecialtyRow(fontSize: fontSize)),
          SliverToBoxAdapter(child: SizedBox(height: 12)),

          /// ⬇ هنا التعديل:
          SliverToBoxAdapter(
            child: CategoriesGrid(
              categories: categories,
              onCategoryTap: (int index){
                    print("تم النقر على التصنيف: ${categories[index].name}");
    
  GoRouter.of(context).push(AppRouter.kServiceProvider,extra:categories[index].name );
    // يمكنك عمل navigation هنا
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => CategoryDetailsPage(category: categories[index])
    // ));
    
    // أو عرض dialog
    // showDialog(...);
              },
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10,
              ),
              child: Text(
                "كبار الأطباء",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: fontSize + 10,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColorC,
                  shadows: [
                    BoxShadow(
                      color: kPrimaryColorC.withValues(alpha: 100),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),

  SliverToBoxAdapter(
  child: SizedBox(
    height: 280, // ارتفاع ثابت للسكرول الأفقي
    child: ListView.builder(
      scrollDirection: Axis.horizontal, // ⬅️ هنا السكرول بالعرض
      itemCount: doctorModelList.length,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CustomDoctorCard(
            iconSize: iconSize,
            doctorModel: doctorModelList[index],
            fontSize: fontSize,
          ),
        );
      },
    ),
  ),
),
        ],
      ),
    ),
    );

  

  }


}
