import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/patient/features/home/categories/data/create_request_model.dart';
import 'package:grad_project/patient/features/requests/data/model/requests_model.dart';

abstract class PRequestsRepo {
  Future<Either<Failure, PRequestsModel>> patientGetRequests(
    int pageindex,
    int pagesize,
    int? status,
  );
  Future<Either<Failure, Unit>> updateRequest({
    required int requestId,
    required DateTime scheduledDate,
    required double latitude,
    required double longitude,
    required String description,
  });
  Future<Either<Failure,String>>cancelRequest({required int requestId,});
}
