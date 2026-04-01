import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_reviews_model.dart';

class ProfileReviewCard extends StatelessWidget {
  final ReviewsModel review;
  final double screenWidth;

  const ProfileReviewCard({
    super.key,
    required this.review,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// صورة المستخدم
            CircleAvatar(
              radius: screenWidth * 0.07,
              backgroundImage: AssetImage(review.image),
            ),

            const SizedBox(width: 12),

            /// بيانات الريفيو
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// الاسم + التقييم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(review.name, style: Styles.textStyle18w400),

                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            review.rate.toString(),
                            style: Styles.textStyle15w400,
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// نص الريفيو
                  Text(
                    review.description ?? "",
                    style: Styles.textStyle16w400.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
