import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/patient/features/home/categories/view_model/repo/ReviewsModel.dart';

abstract class MoreReviewRepo {
  Future<Either<Failure, (List<ReviewModel>, int)>> getReviews({
    required int spId,
    required int pageNumber,
    required int pageSize,
  });
}

class MoreReviewRepoImp implements MoreReviewRepo {
  final ApiConsumer api;
  MoreReviewRepoImp({required this.api});

  @override
  Future<Either<Failure, (List<ReviewModel>, int)>> getReviews({
    required int spId,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final response = await api.get(
        'api/Reviews',
        queryParameters: {
          'serviceProviderId': spId,
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        },
      );

      // الـ ApiConsumer غالباً بيرجع Map<String, dynamic>
      final List items = response['items'] ?? [];
      final List<ReviewModel> reviews = items
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList();

      final int totalCount = response['totalCount'] ?? 0;

      return right((reviews, totalCount));
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
