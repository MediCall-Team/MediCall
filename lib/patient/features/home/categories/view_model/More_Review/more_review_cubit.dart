import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/pagination.dart';
import 'more_review_state.dart';
import '../repo/MoreReviewRepo.dart';
import '../repo/ReviewsModel.dart';

class MoreReviewCubit extends Cubit<MoreReviewState> {
  final MoreReviewRepo repo;
  late PaginationHelper<ReviewModel> paginationHelper;

  MoreReviewCubit(this.repo) : super(MoreReviewInitial());

  void initPagination(int spId) {
    paginationHelper = PaginationHelper<ReviewModel>(
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
