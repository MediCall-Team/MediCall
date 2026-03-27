import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/pagination.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/patient/features/home/categories/repo/more_review_repo.dart';
import 'package:grad_project/patient/features/home/categories/view_model/more_reviews/more_reviews_state.dart';


class MoreReviewCubit extends Cubit<MoreReviewState> {
  final MoreReviewRepo repo;
  late PaginationHelper<ReviewsModel> paginationHelper;

  MoreReviewCubit(this.repo) : super(MoreReviewInitial());

  void initPagination(int spId) {
    paginationHelper = PaginationHelper<ReviewsModel>(
      pageSize: 10,
      fetchPage: (pageIndex, pageSize) async {
        final result = await repo.getReviews(
          spId: spId,
          pageNumber: pageIndex,
          pageSize: pageSize,
        );

        return result.fold((failure) => throw failure.errorMsg, (data) => data);
      },
    );
    loadReviews(); // تحميل أول صفحة فوراً
  }

  Future<void> loadReviews() async {
    if (paginationHelper.isLoading || !paginationHelper.hasMore) return;

    if (paginationHelper.pageIndex == 1) emit(MoreReviewLoading());

    try {
      await paginationHelper.loadNextPage();
      emit(
        MoreReviewSuccess(
          List.from(paginationHelper.items),
          paginationHelper.hasMore,
        ),
      );
    } catch (e) {
      emit(MoreReviewFailure(e.toString()));
    }
  }
}