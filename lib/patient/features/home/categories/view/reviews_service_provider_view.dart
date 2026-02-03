import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/patient/features/home/categories/widgets/add_review_field.dart';
import 'package:grad_project/patient/features/home/categories/widgets/rating_summary_widget.dart';
import 'package:grad_project/patient/features/home/categories/widgets/review_card.dart';

class ReviewsServiceProviderView extends StatelessWidget {
  const ReviewsServiceProviderView({super.key, required this.spReviews});

  final ServiceProviderReviewsModel spReviews;
  // static ServiceProviderReviewsModel spReviews = ServiceProviderReviewsModel(
  //   rate: 4.9,
  //   numPepoleRate: 128,
  //   rateFive: 100,
  //   rateFour: 28,
  //   rateThree: 0,
  //   rateTwo: 0,
  //   rateOne: 0,
  //   reviewsList: [
  //     ReviewsModel(
  //       image: "assets/images/tempphoto.png",
  //       name: "ادهم محمد",
  //       description:
  //           "دكتور محترم جدًا وشرح الحالة بشكل واضح، والزيارة كانت في معادها بالظبط. حسّيت باهتمام ومتابعة كويسة بعد الكشف",
  //       rate: 4.5,
  //     ),
  //     ReviewsModel(
  //       image: "assets/images/tempphoto.png",
  //       name: "ادهم محمد",
  //       description:
  //           "دكتور محترم جدًا وشرح الحالة بشكل واضح، والزيارة كانت في معادها بالظبط. حسّيت باهتمام ومتابعة كويسة بعد الكشف",
  //       rate: 4.5,
  //     ),
  //   ],
  // );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          // قمنا بإزالة الـ Expanded من هنا لحل المشكلة
          mainAxisSize: MainAxisSize.min, // ليأخذ الكولوم مساحة أطفاله فقط
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            RatingSummaryWidget(spReviews: spReviews, screenWidth: screenWidth),
            const SizedBox(height: 30),
             SectionTitle(title: "أضف تقييمك", screenWidth: screenWidth,),
            const SizedBox(height: 12),
             AddReviewField(screenWidth: screenWidth,),
            const SizedBox(height: 30),
             SectionTitle(title: "أحدث التقييمات", screenWidth: screenWidth,),
            const SizedBox(height: 16),

            // قائمة المراجعات
            ListView.separated(
              shrinkWrap: true, // مهم جداً داخل الـ Column
              physics:
                  const NeverScrollableScrollPhysics(), // ليعتمد على سكرول الصفحة الأم
              itemCount: spReviews.reviewsList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                return ReviewCard(
                  review: spReviews.reviewsList[index],
                  screenWidth: screenWidth,
                );
              },
            ),
 
          ],
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
