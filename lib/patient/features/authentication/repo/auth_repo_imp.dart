import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/patient/features/authentication/data/patient_user_model.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';

class PatienAuthRepoImp implements PatienAuthRepo {
  final ApiConsumer api;

  PatienAuthRepoImp({required this.api});

  @override
  Future<Either<Failure, PatientUserModel>> patientLogin({
    required String email,
    required String password,
  }) async {
    try {
      var response = await api.post(
        "api/Authentication/Login",
        data: {"Email": email, "Password": password},
      );
       final user = PatientUserModel.fromJson(
  response as Map<String, dynamic>,
);

    return right(user);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> patientRegister({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    File? image,
  }) async {
    try {
      dynamic imageProfile;

      if (image != null) {
        imageProfile = await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        );
      }

      var formData = FormData.fromMap({
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "Image": imageProfile,
      });

      var response = await api.post("api/Authentication/RegisterPatient", data: formData);

      return right(response);
      
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
