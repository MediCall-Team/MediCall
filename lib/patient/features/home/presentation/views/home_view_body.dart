import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/home/categories/view_model/service_providers_list_cubit/service_providers_list_cubit.dart';
import 'package:grad_project/patient/features/home/data/models/category_model.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/categories_grid.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/custom_doctor_card.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/custom_header_card.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/header.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/specialty_row.dart';
import 'package:lottie/lottie.dart';

class HomeViewBody extends StatefulWidget {
  HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  bool showGreeting = true;
  final List<CategoryModel> categories = categoriesList;

  @override
  void initState() {
    BlocProvider.of<ServiceProvidersListCubit>(context).init("");
    
    // context.read<NotificationNumberCubit>().getMyNotificationsNumber();

   Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => showGreeting = true);
    });

    // 2. بعد 5 ثواني تانية (إجمالي 6) اخفيها
    Timer(const Duration(seconds: 6), () {
      if (mounted) setState(() => showGreeting = false);
    });
  
  
     super.initState();
  }


  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double iconSize = width * 0.06;
    double fontSize = width * 0.04;

    return Scaffold(
      
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: 
      Stack(
  alignment: Alignment.bottomLeft,
  clipBehavior: Clip.none, // عشان النص يقدر يطلع بره حدود الـ Container
  children: [
    // الـ Animation بتاعك
    Container(
      width: 100,
      height: 100,
 color: Colors.transparent,
 
      child: FloatingActionButton(
        
        onPressed: () => GoRouter.of(context).push(AppRouter.kAI),
        backgroundColor: Colors.transparent,
  elevation: 0,
  focusElevation: 0,
  highlightElevation: 0, // هذا السطر يمسح الظل الذي يظهر عند الضغط المطول
  hoverElevation: 0,
  splashColor: Colors.transparent,
  focusColor: Colors.transparent,
  hoverColor: Colors.transparent,
        child: Lottie.asset(
          "assets/animation/eve.json",
          fit: BoxFit.cover,
        ),
      ),
    ),

    // نص "مرحباً" اللي بيظهر ويختفي
    if (showGreeting)
      Positioned(
        top: -20, // ارفعيه فوق الانيميشن
        left: 20,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 1000),
    padding: EdgeInsets.only(bottom: showGreeting ? 10 : 0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1500), // هنا زودنا وقت الظهور نفسه
            opacity: showGreeting ? 1.0 : 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.brandColor(context), // أو أي لون مناسب
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 4),
                ],
              ),
              child: const Text(
                "مرحباً",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ),
        ),
      ),
  ],
),
      // FloatingActionButton(
      //   onPressed: () {
      //     GoRouter.of(context).push(AppRouter.kAI);
      //   },
      //   backgroundColor: Colors.transparent,
      //  // AppTheme.customHeaderCard(context,), // لون الخلفية الدائرية
      //   shape: const CircleBorder(), // لجعل الخلفية دائرية تماماً
      //   child:Lottie.asset("assets/animation/eve.json")  ,//SvgPicture.asset("assets/images/chatbot.svg", width: 30),
      // ),

      
      body: Padding(
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

            BlocBuilder<ServiceProvidersListCubit, ServiceProvidersListState>(
              builder: (context, state) {
                if (state is ServiceProvidersListSuccess) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // اتنين في كل صف
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 6,
                            childAspectRatio: 0.76,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(
                              AppRouter.kServiceProviderProfile,
                              extra: state.doctorSModelList[index].id,
                            );
                          },
                          child: CustomDoctorCard(
                            iconSize: iconSize,
                            doctorModel: state.doctorSModelList[index],
                            fontSize: fontSize,
                            cardWidth: width * 0.45,
                          ),
                        );
                      }, childCount: state.doctorSModelList.length),
                    ),
                  );
                } else if (state is ServiceProvidersListFaliure) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text("not found")),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.brandColor(context),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
