import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';

import 'package:grad_project/service_provider/features/auth/data/s_p_regester_model.dart';

abstract class SpRegesterRepo {
Future<Either<Failure,String>>SpRegesteration({required RegisterRequestModel registermodel});

}
