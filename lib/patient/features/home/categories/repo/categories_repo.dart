import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_profile_model.dart';
import 'package:grad_project/patient/features/home/data/models/doctor_model.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, (List<DoctorModel>, int)>> getProvidersList(
    {
      required int pageIndex, required int pageSize ,  required String specialty,
      int? gender,
    String? area,
    double? minPrice,
    double? maxPrice,
    String? search,
    }
  );

  Future<Either<Failure,ServiceProviderProfileModel>> getProviderProfile(
    {
      required int id
    }
  );
  
   Future<Either<Failure,String>> addReview(
    {
      required int id,
      required int ratingValue,
      String? comment,
      int? requestId 
    }
  );
  
}