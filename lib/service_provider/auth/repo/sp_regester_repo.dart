import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/patient/features/authentication/data/patient_user_model.dart';
import 'package:grad_project/service_provider/auth/data/s_p_regester_model.dart';

abstract class SpRegesterRepo {
Future<Either<Failure,String>>SpRegesteration({required RegisterRequestModel registermodel});


}
