
import 'package:flutter/material.dart';
import 'package:grad_project/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/features/home/categories/widgets/handle_stars_rate.dart';
import 'package:grad_project/features/home/categories/widgets/rate_bar.dart';

class RatingSummaryWidget extends StatelessWidget {
  final ServiceProviderReviewsModel spReviews;
  final double screenWidth;

  const RatingSummaryWidget({
    super.key,
    required this.spReviews,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF1F9FD).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                RateBar(
                  label: "5",
                  screenWidth: screenWidth,
                  count: spReviews.rateFive,
                  total: spReviews.numPepoleRate,
                ),
                RateBar(
                  label: "4",
                   screenWidth: screenWidth,
                  count: spReviews.rateFour,
                  total: spReviews.numPepoleRate,
                ),
                RateBar(
                  label: "3",
                   screenWidth: screenWidth,
                  count: spReviews.rateThree,
                  total: spReviews.numPepoleRate,
                ),
                RateBar(
                  label: "2",
                   screenWidth: screenWidth,
                  count: spReviews.rateTwo,
                  total: spReviews.numPepoleRate,
                ),
                RateBar(
                  label: "1",
                   screenWidth: screenWidth,
                  count: spReviews.rateOne,
                  total: spReviews.numPepoleRate,
                ),
              ],
            ),
          ),

          const SizedBox(width: 24),

          Column(
            children: [
              Text(
                "${spReviews.rate}",
                style:  TextStyle(
                  fontSize: (screenWidth*0.1).clamp(20, 60),//48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              StarsRate(rate: spReviews.rate, screenWidth: screenWidth),
              const SizedBox(height: 4),
              Text(
                "(${spReviews.numPepoleRate.toInt()} تقييم)",
                style:  TextStyle(color: Colors.grey
                , fontSize:screenWidth*0.038,
                fontWeight: FontWeight.bold ////12
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}