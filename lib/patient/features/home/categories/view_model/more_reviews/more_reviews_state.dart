import 'package:grad_project/patient/features/home/categories/data/service_provider_reviews_model.dart';

sealed class MoreReviewState {}

final class MoreReviewInitial extends MoreReviewState {}

final class MoreReviewLoading extends MoreReviewState {}

final class MoreReviewSuccess extends MoreReviewState {
  final List<ReviewsModel> reviews;
  final bool hasMore;
  MoreReviewSuccess(this.reviews, this.hasMore);
}

final class MoreReviewFailure extends MoreReviewState {
  final String errMessage;
  MoreReviewFailure(this.errMessage);
}