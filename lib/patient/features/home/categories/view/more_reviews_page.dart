import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grad_project/patient/features/home/categories/view_model/More_Review/more_review_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/More_Review/more_review_state.dart';
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
    // مراقبة السكرول لطلب المزيد
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.9) {
        // التأكد إننا مش بننادي التحميل مرتين في نفس الوقت
        final cubit = context.read<MoreReviewCubit>();
        if (!cubit.paginationHelper.isLoading) {
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
          if (state is MoreReviewLoading)
            return const Center(child: CircularProgressIndicator());
          if (state is MoreReviewFailure)
            return Center(child: Text(state.errMessage));

          final reviews = context
              .read<MoreReviewCubit>()
              .paginationHelper
              .items;
          final hasMore = context
              .read<MoreReviewCubit>()
              .paginationHelper
              .hasMore;

          if (reviews.isEmpty)
            return const Center(child: Text("لا توجد تقييمات إضافية"));

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
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator(),
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
