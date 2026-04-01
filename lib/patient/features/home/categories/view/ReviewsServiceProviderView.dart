import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/patient/features/home/categories/view/more_review_page.dart';
import 'package:grad_project/patient/features/home/categories/view_model/more_reviews/more_reviews_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/repo/MoreReviewRepo.dart';
import 'package:grad_project/patient/features/home/categories/widgets/add_review_field.dart';
import 'package:grad_project/patient/features/home/categories/widgets/rating_summary_widget.dart';
import 'package:grad_project/patient/features/home/categories/widgets/review_card.dart';
import 'package:grad_project/patient/features/home/categories/widgets/stagged_step_animation.dart';

class ReviewsServiceProviderView extends StatelessWidget {
  ReviewsServiceProviderView({
    super.key,
    required this.spReviews,
    required this.id,
  });

  final ServiceProviderReviewsModel spReviews;
  final String role = CacheHelper.getUser()?.role ?? "";
  final int id;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    List<Widget> children = [
      RatingSummaryWidget(spReviews: spReviews, screenWidth: screenWidth),
      const SizedBox(height: 30),

      if (role == "Patient")
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: "أضف تقييمك", screenWidth: screenWidth),
            const SizedBox(height: 12),
            AddReviewField(screenWidth: screenWidth),
            const SizedBox(height: 30),
          ],
        ),

      SectionTitle(title: "أحدث التقييمات", screenWidth: screenWidth),
      const SizedBox(height: 16),
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: spReviews.reviewsList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) => ReviewCard(
          review: spReviews.reviewsList[index],
          screenWidth: screenWidth,
        ),
      ),

      const SizedBox(height: 20),

      Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        MoreReviewCubit(getIt<MoreReviewRepo>())
                          ..initPagination(id),
                    child: MoreReviewsPage(serviceProviderId: id),
                  ),
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              decoration: BoxDecoration(
                color: const Color(0xffF3F6FB),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xff1F3E6C).withOpacity(.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.reviews_outlined,
                    color: Color(0xff1F3E6C),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "عرض المزيد من التقييمات",
                    style: TextStyle(
                      color: Color(0xff1F3E6C),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Color(0xff1F3E6C),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: spReviews.reviewsList.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  children.length,
                  (index) => StaggeredStepAnimation(
                    index: index,
                    child: children[index],
                  ),
                ),
              )
            : const Center(child: Text("لا توجد تقييمات")),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final double screenWidth;

  const SectionTitle({
    super.key,
    required this.title,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: screenWidth * 0.044,
        fontWeight: FontWeight.bold,
        color: AppTheme.mainContrast(context),
      ),
    );
  }
}
