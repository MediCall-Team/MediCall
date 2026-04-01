import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/home/categories/view_model/more_reviews/more_reviews_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/more_reviews/more_reviews_state.dart';
import 'package:grad_project/patient/features/home/categories/widgets/review_card.dart';

class MoreReviewsPage extends StatefulWidget {
  final int serviceProviderId;
  const MoreReviewsPage({super.key, required this.serviceProviderId});

  @override
  State<MoreReviewsPage> createState() => _MoreReviewsPageState();
}

class _MoreReviewsPageState extends State<MoreReviewsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.9) {
        final cubit = context.read<MoreReviewCubit>();
        if (!cubit.paginationHelper.isLoading &&
            cubit.paginationHelper.hasMore) {
          cubit.loadReviews();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(title: const Text("باقي التقييمات")),
      body: BlocBuilder<MoreReviewCubit, MoreReviewState>(
        builder: (context, state) {
          final cubit = context.read<MoreReviewCubit>();
          final reviews = cubit.paginationHelper.items;
          final hasMore = cubit.paginationHelper.hasMore;

          if (state is MoreReviewLoading && reviews.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: AppTheme.brandColor(context),
              ),
            );
          }

          if (state is MoreReviewFailure && reviews.isEmpty) {
            return Center(child: Text(state.errMessage));
          }

          if (reviews.isEmpty) {
            return const Center(child: Text("لا توجد تقييمات إضافية"));
          }

          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: reviews.length + (hasMore ? 1 : 0),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                if (index < reviews.length) {
                  return ReviewCard(
                    review: reviews[index],
                    screenWidth: screenWidth,
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        color: AppTheme.brandColor(context),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
