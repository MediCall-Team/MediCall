import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/patient/features/home/categories/view/more_review_page.dart';
import 'package:grad_project/patient/features/home/categories/view_model/more_reviews/more_reviews_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/repo/MoreReviewRepo.dart';
import 'package:grad_project/patient/features/home/categories/view_model/repo/ReviewsModel.dart';
import 'package:grad_project/patient/features/home/categories/view_model/when_add_review/when_add_review_cubit.dart';
import 'package:grad_project/patient/features/home/categories/widgets/add_review_field.dart';
import 'package:grad_project/patient/features/home/categories/widgets/rating_summary_widget.dart';
import 'package:grad_project/patient/features/home/categories/widgets/review_card.dart';
import 'package:grad_project/patient/features/home/categories/widgets/stagged_step_animation.dart';

class ReviewsServiceProviderView extends StatefulWidget {
  const ReviewsServiceProviderView({
    super.key,
    required this.spReviews,
    required this.id,
  });

  final ServiceProviderReviewsModel spReviews;
  final int id;

  @override
  State<ReviewsServiceProviderView> createState() =>
      _ReviewsServiceProviderViewState();
}

class _ReviewsServiceProviderViewState
    extends State<ReviewsServiceProviderView> {
  final String role = CacheHelper.getUser()?.role ?? "";

  late List<ReviewsModel> currentReviews;

  @override
  void initState() {
    super.initState();
    currentReviews = widget.spReviews.reviewsList;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return BlocListener<WhenAddReviewCubit, WhenAddReviewState>(
      listener: (context, state) {
        if (state is WhenAddReviewSuccess) {
          setState(() {
            currentReviews = state.reviewsList;
          });
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ⭐ Rating Summary
                StaggeredStepAnimation(
                  index: 0,
                  child: RatingSummaryWidget(
                    spReviews: widget.spReviews,
                    screenWidth: screenWidth,
                  ),
                ),
                const SizedBox(height: 30),

                /// ➕ Add Review
                if (role == "Patient") ...[
                  StaggeredStepAnimation(
                    index: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(
                          title: "أضف تقييمك",
                          screenWidth: screenWidth,
                        ),
                        const SizedBox(height: 12),
                        AddReviewField(
                          screenWidth: screenWidth,
                          id: widget.id,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],

                /// 📌 Reviews Section
                BlocBuilder<WhenAddReviewCubit, WhenAddReviewState>(
                  buildWhen: (previous, current) =>
                      current is WhenAddReviewLoading ||
                      current is WhenAddReviewSuccess,
                  builder: (context, state) {
                    if (state is WhenAddReviewLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (currentReviews.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text("لا توجد تقييمات بعد"),
                        ),
                      );
                    }

                    return StaggeredStepAnimation(
                      index: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitle(
                            title: "أحدث التقييمات",
                            screenWidth: screenWidth,
                          ),
                          const SizedBox(height: 16),

                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: currentReviews.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final review = currentReviews[index];

                              return ReviewCard(
                                review: review,
                                screenWidth: screenWidth,
                              );
                            },
                          ),

                          const SizedBox(height: 20),

                          _buildMoreReviewsButton(context),

                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreReviewsButton(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => MoreReviewCubit(getIt<MoreReviewRepo>())
                    ..initPagination(widget.id),
                  child: MoreReviewsPage(serviceProviderId: widget.id),
                ),
              ),
            );
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            decoration: BoxDecoration(
              color: const Color(0xffF3F6FB),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xff1F3E6C).withOpacity(.2),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.reviews_outlined,
                    color: Color(0xff1F3E6C), size: 20),
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
                Icon(Icons.arrow_forward_ios,
                    size: 15, color: Color(0xff1F3E6C)),
              ],
            ),
          ),
        ),
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