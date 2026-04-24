import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/patient/features/profile/data/report_model.dart';

abstract class PatientRecordRepo {
    Future<Either<Failure,List< ReportModel>>> getReports({required int patientId});
}