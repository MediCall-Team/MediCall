import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/patient/features/requests/data/model/requests_model.dart';
import 'package:grad_project/patient/features/requests/repo/p_requests_repo.dart';

class PRequestsRepoImp extends PRequestsRepo {
  final ApiConsumer api;

  PRequestsRepoImp({required this.api});
  @override
  Future<Either<Failure, PRequestsModel>> patientGetRequests(
    int pageindex,
    int pagesize,
    int? status,
  ) async {
    try {
      var response = await api.get(
        "api/Requests",
        queryParameters: {
          "PageIndex": pageindex,
          "PageSize": pagesize,
          if (status != null) "status": status,
        },
      );

      return right(PRequestsModel.fromJson(response));
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateRequest({
    required int requestId,
    required DateTime scheduledDate,
    required double latitude,
    required double longitude,
    required String description,
  }) async {
    try {
      var response = await api.put(
        "api/Requests/$requestId",
        data: {
          'description': description,
          'scheduledDate': scheduledDate.toUtc().toIso8601String(),
          'longitude': longitude,
          'latitude': latitude,
        },
      );
      log(response.toString());
      return right(unit);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> cancelRequest({
    required int requestId,
  }) async {
    try {
      var response = await api.delete('api/Requests/$requestId');
      if (response is Map && response.containsKey('message')) {
        return Right(response['message'] as String);
      } else if (response is String) {
        return Right(response);
      } else {
        return Right("تم حذف الطلب بنجاح");
      }
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
