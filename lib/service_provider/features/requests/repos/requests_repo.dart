import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/service_provider/features/requests/data/model/requests_model.dart';

abstract class RequestsRepo {
  Future<Either<Failure, RequestsModel>> getAllRecuests(
    int PageIndex,
    int PageSize,
    int? status,
  );
  Future<Either<Failure, String>> acceptRequest(int requestID);
  Future<Either<Failure, String>> rejectRequest(int requestID);
  Future<Either<Failure, String>> createReport(int requestID,String description );
}
