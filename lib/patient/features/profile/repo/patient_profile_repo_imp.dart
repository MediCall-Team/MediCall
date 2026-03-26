import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/patient/features/profile/data/patient_profile_model.dart';
import 'package:grad_project/patient/features/profile/repo/patient_profile_repo.dart';

class PatientProfileRepoImp implements PatientProfileRepo {
  final ApiConsumer api;

  PatientProfileRepoImp({required this.api});

  @override
  Future<Either<Failure, PatientProfileModel>> getPatientProfileData() async {
    try {
      final response = await api.get("api/Profile");

      final patientProfile = PatientProfileModel.fromJson(response);

      return right(patientProfile);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PatientProfileModel>> updatePatientProfileData({
    required String FirstName,
    required String LastName,
    required String PhoneNumber,
    File? Image,
    required bool IsImageRemoved,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "FirstName": FirstName,
        "LastName": LastName,
        "PhoneNumber": PhoneNumber,
        "IsImageRemoved": IsImageRemoved,
        if (Image != null) "Image": await MultipartFile.fromFile(Image.path),
      });

      var response = await api.put(
        'api/Profile/UpdateMyProfile',
        data: formData,
      );

      final patientProfile = PatientProfileModel.fromJson(response);

      return right(patientProfile);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
