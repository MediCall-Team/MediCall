import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/patient/features/profile/data/patient_profile_model.dart';

abstract class PatientProfileRepo {
   Future<Either<Failure,PatientProfileModel>>getPatientProfileData();
}