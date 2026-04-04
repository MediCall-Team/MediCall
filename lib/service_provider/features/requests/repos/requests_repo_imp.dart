import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/service_provider/features/requests/data/model/requests_model.dart';
import 'package:grad_project/service_provider/features/requests/repos/requests_repo.dart';

class RequestsRepoImp extends RequestsRepo {
  final ApiConsumer api;

  RequestsRepoImp({required this.api});
  @override
  Future<Either<Failure, RequestsModel>> getAllRecuests(
    int pageIndex,
    int pageSize,
    int? status,
  ) async {
    try {
      var response = await api.get(
        "api/Providers/requests",
        queryParameters: {
          "PageIndex": pageIndex,
          "PageSize": pageSize,
          if (status != null) "status": status,
        },
      );

      return right(RequestsModel.fromJson(response));
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
