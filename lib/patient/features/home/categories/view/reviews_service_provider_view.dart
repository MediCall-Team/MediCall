
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/patient/features/home/categories/view/more_review_page.dart';
import 'package:grad_project/patient/features/home/categories/view_model/More_Review/more_review_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/repo/MoreReviewRepo.dart';
import 'package:grad_project/patient/features/home/categories/widgets/add_review_field.dart';
import 'package:grad_project/patient/features/home/categories/widgets/rating_summary_widget.dart';
import 'package:grad_project/patient/features/home/categories/widgets/review_card.dart';
import 'package:grad_project/patient/features/home/categories/widgets/stagged_step_animation.dart';

class ReviewsServiceProviderView extends StatelessWidget {
   ReviewsServiceProviderView({
    super.key, required this.spReviews,
    required this.id});
  final ServiceProviderReviewsModel spReviews;
  final String role= CacheHelper.getUser()!.role;
  final int id;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    // قائمة بالعناصر لسهولة عمل Loop عليها بالـ Index
    List<Widget> children = [

      RatingSummaryWidget(spReviews: spReviews, screenWidth: screenWidth),
      const SizedBox(height: 30),

  role == "Patient"?  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        SectionTitle(title: "أضف تقييمك", screenWidth: screenWidth),
      const SizedBox(height: 12),
      AddReviewField(screenWidth: screenWidth),
      const SizedBox(height: 30),
    ],):SizedBox(),
    


      SectionTitle(title: "أحدث التقييمات", screenWidth: screenWidth),
      const SizedBox(height: 16),
      // المراجعات نفسها سنعرضها كعنصر واحد أو نفككها
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: spReviews.reviewsList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) => ReviewCard(review: spReviews.reviewsList[index], 
        screenWidth: screenWidth),
      ),


       const SizedBox(height: 12),
      Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  // بنستخدم الـ Repo اللي عملناه بالـ ApiConsumer
                  create: (context) => MoreReviewCubit(
                    getIt<MoreReviewRepo>(), // لو بتستخدمي GetIt
                  )..initPagination(id),
                  child: MoreReviewsPage(serviceProviderId: id),
                ),
              ),
            );
          },
          child: const Text(
            "المزيد من التقييمات .........",
            style: TextStyle(
              color: Color(0xff1F3E6C),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: spReviews.reviewsList.isNotEmpty?
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(children.length, (index) {
            return StaggeredStepAnimation(
              index: index,
              child: children[index],
            );
          }),
        ):
        Center(child: Text("لا توجد تقييمات"),)
        ,
      ),
    );
  }
}

// --- تحويل الـ Methods إلى Widgets منفصلة ---


class SectionTitle extends StatelessWidget {
  final String title;
  final double screenWidth;
  const SectionTitle({super.key, required this.title, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:  TextStyle(
        fontSize:screenWidth*0.044,// 18,
        fontWeight: FontWeight.bold,
        color:AppTheme.mainContrast(context), //Color(0xff1F3E6C),
      ),
    );
  }
}