// Service_profile_Repo.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/widgets/ServiceProfileModel.dart';

abstract class SPProfileRepo {
  Future<Either<Failure, ProviderProfileModel>> getProviderProfile();
  Future<Either<Failure, ProviderProfileModel>> updateProviderProfile(
    Map<String, dynamic> body,
  );
}

class SPProfileRepoImpl implements SPProfileRepo {
  final ApiConsumer api;

  SPProfileRepoImpl(this.api);

  @override
  Future<Either<Failure, ProviderProfileModel>> getProviderProfile() async {
    try {
      final user = await CacheHelper.getUser();
      final token = user?.token ?? "";

      final response = await api.get(
        'api/Profile/GetProviderProfile',
        queryParameters: {'token': token},
      );

      final Map<String, dynamic> jsonMap;
      if (response is Map<String, dynamic>) {
        jsonMap =
            response['data'] != null && response['data'] is Map<String, dynamic>
            ? response['data'] as Map<String, dynamic>
            : response as Map<String, dynamic>;
      } else {
        throw Exception(
          'Unexpected API response format: ${response.runtimeType}',
        );
      }

      final profile = ProviderProfileModel.fromJson(jsonMap);
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // داخل Service_profile_Repo.dart
  @override
  Future<Either<Failure, ProviderProfileModel>> updateProviderProfile(
    Map<String, dynamic> body,
  ) async {
    try {
      final user = await CacheHelper.getUser();
      final token = user?.token ?? "";

      final response = await api.put(
        'api/Profile/UpdateProviderProfile',
        data: body,
        queryParameters: {'token': token},
      );

      final Map<String, dynamic> jsonMap;
      if (response is Map<String, dynamic>) {
        jsonMap =
            response['data'] != null && response['data'] is Map<String, dynamic>
            ? response['data'] as Map<String, dynamic>
            : response as Map<String, dynamic>;
      } else {
        throw Exception(
          'Unexpected API response format: ${response.runtimeType}',
        );
      }

      final profile = ProviderProfileModel.fromJson(jsonMap);
      return Right(profile);
    } on DioError catch (dioErr) {
      // استخراج آمن لبيانات الاستجابة
      try {
        final respData = dioErr.response?.data;

        // إذا كانت الاستجابة خريطة JSON
        if (respData is Map<String, dynamic>) {
          // حالات validation errors
          if (respData.containsKey('errors')) {
            final errors = respData['errors'] as Map<String, dynamic>;
            final messages = errors.values
                .map((v) {
                  if (v is List) return v.join(', ');
                  return v.toString();
                })
                .join(' | ');
            return Left(ServerFailure(messages));
          }

          // title / message
          if (respData.containsKey('title')) {
            return Left(ServerFailure(respData['title'].toString()));
          }
          if (respData.containsKey('message')) {
            return Left(ServerFailure(respData['message'].toString()));
          }

          // لو الخريطة تحتوي على حقل واحد نصي
          return Left(ServerFailure(respData.toString()));
        }

        // لو الاستجابة نصية أو null، استخدم رسالة Dio أو toString
        final dioMessage =
            dioErr.message ?? dioErr.error?.toString() ?? dioErr.toString();
        return Left(ServerFailure(dioMessage));
      } catch (e) {
        final fallback =
            dioErr.message ?? dioErr.error?.toString() ?? dioErr.toString();
        return Left(ServerFailure(fallback));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
