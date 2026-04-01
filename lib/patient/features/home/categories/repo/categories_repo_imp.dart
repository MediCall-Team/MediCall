import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
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
}
