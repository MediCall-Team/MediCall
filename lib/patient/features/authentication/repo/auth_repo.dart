import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/patient/features/authentication/data/patient_user_model.dart';

abstract class PatienAuthRepo{
 Future<Either<Failure,PatientUserModel>>patientLogin(
  {
    required String email,
    required String password,
  }
 );
  
   Future<Either<Failure,String>>patientRegister(
  {
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    File? image,
  }
 );


}