import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/helper/reusable_shimmer.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:grad_project/patient/features/home/categories/view_model/service_providers_list_cubit/service_providers_list_cubit.dart';
import 'package:grad_project/patient/features/home/data/models/category_model.dart';
import 'package:grad_project/patient/features/home/data/models/doctor_model.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/categories_grid.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/custom_doctor_card.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/custom_header_card.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/header.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/specialty_row.dart';

class HomeViewBody extends StatefulWidget {
  HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<CategoryModel> categories = categoriesList;

  @override
  void initState() {
    BlocProvider.of<ServiceProvidersListCubit>(context).init("");
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double iconSize = width * 0.06;
    double fontSize = width * 0.04;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: Header(
              fontSize: fontSize,
              iconSize: iconSize,
              screenWidth: width,
            ),
          ),
    
          SliverToBoxAdapter(child: SizedBox(height: 50)),
          SliverToBoxAdapter(
            child: CustomHeaderCard(fontSize: fontSize, screenWidth: width),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 18)),
          SliverToBoxAdapter(child: SpecialtyRow(fontSize: fontSize)),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
    
          /// ⬇ هنا التعديل:
          SliverToBoxAdapter(
            child: CategoriesGrid(
              categories: categories,
              onCategoryTap: (int index) {
                //  print("تم النقر على التصنيف: ${categories[index].name}");
                if (index == 5) {
                  GoRouter.of(context).push(AppRouter.kmoreCategories);
                } else {
                  GoRouter.of(context).push(
                    AppRouter.kServiceProvider,
                    extra: categories[index].name,
                  );
                }
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
                vertical: 20,
              ),
              child: Text(
                "كبار الأطباء",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: (fontSize + 10).clamp(12, 25),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.brandColor(
                    context,
                  ), //AppTheme.secondary(context),//kPrimaryColorC,
                ),
              ),
            ),
          ),
    
          SliverToBoxAdapter(
            child: SizedBox(
              // الارتفاع سيكون 40% من عرض الشاشة أو قيمة محددة بين حدين
              height: (width * 0.5).clamp(250, 380),
              child: BlocBuilder<ServiceProvidersListCubit, ServiceProvidersListState>(
                builder: (context, state) {
                  return 
                  state is ServiceProvidersListSuccess?
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.doctorSModelList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      return CustomDoctorCard(
                        iconSize: iconSize,
                        doctorModel: state.doctorSModelList[index],
                        fontSize: fontSize,
                        // نمرر عرض الكارت ليكون متناسباً
                        cardWidth: (width * 0.50).clamp(160, 240),
                      );
                    },
                  ):   state is ServiceProvidersListFaliure ?
                  Center(child: Text("not found"),):
                 Center(child: CircularProgressIndicator(color: AppTheme.brandColor(context),),);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
