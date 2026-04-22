part of 'when_add_review_cubit.dart';

@immutable
sealed class WhenAddReviewState {}

final class WhenAddReviewInitial extends WhenAddReviewState {}

final class WhenAddReviewLoading extends WhenAddReviewState {}

final class WhenAddReviewSuccess extends WhenAddReviewState {
  final List<ReviewsModel> reviewsList;

  WhenAddReviewSuccess({required this.reviewsList});
}

final class WhenAddReviewFailure extends WhenAddReviewState {
  final String errorMsg;

  WhenAddReviewFailure({required this.errorMsg});
}