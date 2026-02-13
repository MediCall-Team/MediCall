import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/patient/features/home/categories/widgets/add_review_field.dart';
import 'package:grad_project/patient/features/home/categories/widgets/rating_summary_widget.dart';
import 'package:grad_project/patient/features/home/categories/widgets/review_card.dart';
import 'package:grad_project/patient/features/home/categories/widgets/stagged_step_animation.dart';

class ReviewsServiceProviderView extends StatelessWidget {
  const ReviewsServiceProviderView({super.key, required this.spReviews});
  final ServiceProviderReviewsModel spReviews;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    // قائمة بالعناصر لسهولة عمل Loop عليها بالـ Index
    List<Widget> children = [
      RatingSummaryWidget(spReviews: spReviews, screenWidth: screenWidth),
      const SizedBox(height: 30),
      SectionTitle(title: "أضف تقييمك", screenWidth: screenWidth),
      const SizedBox(height: 12),
      AddReviewField(screenWidth: screenWidth),
      const SizedBox(height: 30),
      SectionTitle(title: "أحدث التقييمات", screenWidth: screenWidth),
      const SizedBox(height: 16),
      // المراجعات نفسها سنعرضها كعنصر واحد أو نفككها
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: spReviews.reviewsList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) => ReviewCard(review: spReviews.reviewsList[index], screenWidth: screenWidth),
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(children.length, (index) {
            return StaggeredStepAnimation(
              index: index,
              child: children[index],
            );
          }),
        ),
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
        color: Color(0xff1F3E6C),
      ),
    );
  }
}
