import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/patient/features/profile/data/patient_profile_model.dart';
import 'package:grad_project/patient/features/profile/data/report_model.dart';

abstract class PatientProfileRepo {
  Future<Either<Failure, PatientProfileModel>> getPatientProfileData();
  Future<Either<Failure, PatientProfileModel>> updatePatientProfileData({
    required String FirstName,
    required String LastName,
    required String PhoneNumber,
    File? Image,
    required bool IsImageRemoved,
  });

  Future<Either<Failure,List< ReportModel>>> getReports();
}
