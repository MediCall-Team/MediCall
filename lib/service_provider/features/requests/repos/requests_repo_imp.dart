import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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

  @override
  Future<Either<Failure, String>> acceptRequest(int requestID) async {
    try {
      var response = await api.put('api/Providers/accept/$requestID');

      // التحقق من أن response يحتوي على message
      if (response is Map && response.containsKey('message')) {
        return Right(response['message'] as String);
      } else if (response is String) {
        return Right(response);
      } else {
        return Right("تم قبول الطلب بنجاح");
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> rejectRequest(int requestID) async {
    try {
      var response = await api.put('api/Providers/reject/$requestID');

      // التحقق من أن response يحتوي على message
      if (response is Map && response.containsKey('message')) {
        return Right(response['message'] as String);
      } else if (response is String) {
        return Right(response);
      } else {
        return Right("تم رفض الطلب بنجاح");
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createReport(
    int requestID,
    String description,
  ) async {
    try {
      final Map<String, dynamic> data = {
        "RequestId": requestID,
        "Description": description,
      };

      var response = await api.post('api/Reports/createReport', data: data);

      // التحقق من نوع الـ response
      if (response is Map && response.containsKey('message')) {
        return Right(response['message'] as String);
      } else if (response is String) {
        return Right(response);
      } else {
        return Right("تم إرسال التقرير بنجاح");
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
