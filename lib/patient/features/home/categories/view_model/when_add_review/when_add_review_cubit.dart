import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/patient/features/home/categories/view_model/repo/MoreReviewRepo.dart';
import 'package:grad_project/patient/features/home/categories/view_model/repo/ReviewsModel.dart';
import 'package:meta/meta.dart';

part 'when_add_review_state.dart';

class WhenAddReviewCubit extends Cubit<WhenAddReviewState> {
  WhenAddReviewCubit(this.repo) : super(WhenAddReviewInitial());

  final MoreReviewRepo repo;

  Future<void> getReviewsAfterAdd({required int spId}) async {
    emit(WhenAddReviewLoading());

    final result = await repo.getReviews(
      spId: spId,
      pageNumber: 1,
      pageSize: 10,
    );

    result.fold(
  (failure) {
    emit(WhenAddReviewFailure(errorMsg: failure.errorMsg));
  },
  (data) {
    final mappedReviews = data.$1.map((e) {
      return ReviewsModel(
        image: e.image ?? "",
        name: e.name,
        description: e.description ?? "",
        rate: e.rate,
        createdAt: e.createdAt,
      );
    }).toList();

    emit(
      WhenAddReviewSuccess(reviewsList: mappedReviews),
    );
  },
);
  }
}