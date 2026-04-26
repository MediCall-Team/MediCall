// Service_profile_Repo.dart
import 'dart:developer';
import 'dart:io';
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

  Future<Either<Failure, String>> addAreas(List<int> areaIds);
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
      log("sp profile in repo ${profile.doctorServiceAreas.length}");
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// ===============================
  /// UPDATE PROVIDER PROFILE
  /// ===============================
  Future<Either<Failure, ProviderProfileModel>> updateProviderProfile(
    Map<String, dynamic> body,
  ) async {
    try {
      final user = await CacheHelper.getUser();
      final token = user?.token ?? "";

      /// تحويل البيانات إلى FormData لأن الـ API يستقبل صورة
      final formData = FormData();

      body.forEach((key, value) {
        if (value == null) return;

        /// لو الصورة File
        if (key == "ProfileImage" && value is File) {
          formData.files.add(
            MapEntry(key, MultipartFile.fromFileSync(value.path)),
          );
        }
        /// لو الـ Description
        else if (key == "Description" && value is String) {
          formData.fields.add(MapEntry("Description", value));
        }
        /// لو قائمة المراكز
        else if (key == "AreaIds" && value is List<int>) {
          if (value.isNotEmpty) {
            for (var id in value) {
              formData.fields.add(MapEntry("AreaIds", id.toString()));
            }
          }
        }
        /// باقي البيانات
        else {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      final response = await api.put(
        'api/Profile/UpdateProviderProfile',
        data: formData,
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
      try {
        final respData = dioErr.response?.data;

        if (respData is Map<String, dynamic>) {
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

          if (respData.containsKey('title')) {
            return Left(ServerFailure(respData['title'].toString()));
          }

          if (respData.containsKey('message')) {
            return Left(ServerFailure(respData['message'].toString()));
          }

          return Left(ServerFailure(respData.toString()));
        }

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

  // ===============================
  /// ADD AREAS TO PROVIDER
  /// ===============================
  @override
  Future<Either<Failure, String>> addAreas(List<int> areaIds) async {
    try {
      final user = await CacheHelper.getUser();
      final token = user?.token ?? "";

      final response = await api.post(
        'api/Area/add-areas',
        data: {"areaIds": areaIds},
        queryParameters: {'token': token},
      );

      return Right("تم حفظ المناطق بنجاح");
    } on DioException catch (dioErr) {
      return Left(ServerFailure.dioException(dioErr));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
