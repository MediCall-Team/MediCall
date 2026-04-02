import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:meta/meta.dart';

part 'add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  AddReviewCubit(this.repo) : super(AddReviewInitial());
  final CategoriesRepo repo;

  Future<void> addReview({
    required int id,
    required int ratingValue,
    String? comment,
    int? requestId,
  }) async {
    emit(AddReviewLoading());
    var data = await repo.addReview(
      id: id,
      ratingValue: ratingValue,
      comment: comment,
      requestId: requestId,
    );
    data.fold(
      (failure) {
        log("failure in add review ${failure.errorMsg}");
        emit(AddReviewFailure(errorMsg: failure.errorMsg));
      },
      (_) {
        emit(AddReviewSuccess());
      },
    );
  }
}
