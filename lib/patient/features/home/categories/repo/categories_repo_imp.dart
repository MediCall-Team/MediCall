import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/patient/features/home/categories/data/create_request_model.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_profile_model.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:grad_project/patient/features/home/data/models/doctor_model.dart';

class CategoriesRepoImp implements CategoriesRepo {
  final ApiConsumer api;

  CategoriesRepoImp({required this.api});
  @override
  Future<Either<Failure, (List<DoctorModel>, int)>> getProvidersList({
    required int pageIndex,
    required int pageSize,
    required String specialty,
    int? gender,
    String? area,
    double? minPrice,
    double? maxPrice,
    String? search,
  }) async {
    try {
      var response = await api.get(
        "api/Providers",
        queryParameters: {
          "PageIndex": pageIndex,
          "PageSize": pageSize,
          "Specialization": specialty,
          if (gender != null) "Gender": gender,
          if (area != null) "Area": area,
          if (minPrice != null) "MinPrice": minPrice,
          if (maxPrice != null) "MaxPrice": maxPrice,
          if (search != null && search.isNotEmpty) "Search": search,
        },
      );

      List<DoctorModel> list = (response["data"] as List)
          .map((e) => DoctorModel.fromJson(e))
          .toList();

      int count = response["count"];

      return right((list, count));
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  /////////////

  @override
  Future<Either<Failure, ServiceProviderProfileModel>> getProviderProfile({
    required int id,
  }) async {
    try {
      var response = await api.get("api/Providers/$id");
      ServiceProviderProfileModel serviceProviderProfileData =
          ServiceProviderProfileModel.fromJson(response);
      return right(serviceProviderProfileData);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addReview({
    required int id,
    required int ratingValue,
    String? comment,
    int? requestId,
  }) async {
    try {
      var response = await api.post(
        "api/Reviews",
        data: {
          "serviceProviderId": id,
          "RequestId": requestId,
          "ratingValue": ratingValue,
          "comment": comment,
        },
      );
      return right(response["message"]);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> createRequest({required CreateRequestModel createRequestModel})async {
    try {
      var response = await api.post(
        "api/Requests",
        data: {
            'serviceProviderId':createRequestModel. serviceProviderId,
      'PatientFirstName':createRequestModel. patientFirstName,
      'PatientLastName':createRequestModel. patientLastName,
      'description':createRequestModel. description,
      'scheduledDate':createRequestModel. scheduledDate.toUtc().toIso8601String(),
      'latitude':createRequestModel. latitude,
      'longitude':createRequestModel. longitude,
         // createRequestModel.toJson()
        },
      );
     
     log("time : ${createRequestModel.scheduledDate.toUtc().toIso8601String()}");
      return right(unit);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
