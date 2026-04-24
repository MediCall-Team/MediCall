import 'package:dartz/dartz.dart';
import 'package:grad_project/common/chat/patient_records/repo/patient_record_repo.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/patient/features/profile/data/report_model.dart';

class PatientRecordRepoImp extends PatientRecordRepo {
  final ApiConsumer api;

  PatientRecordRepoImp({required this.api});

  @override
  Future<Either<Failure, List<ReportModel>>> getReports({
    required int patientId,
  }) async {
    try {
      final response = await api.get("api/Reports/providerReports/$patientId");

      List<ReportModel> reports = [];

      // ✅ الـ response نفسه هو اللي list مباشرة
      if (response is List) {
        reports = (response as List)
            .map((reportJson) => ReportModel.fromJson(reportJson))
            .toList();
      } else if (response['data'] is List) {
        // لو في wrapper زي {"data": [...]}
        reports = (response['data'] as List)
            .map((reportJson) => ReportModel.fromJson(reportJson))
            .toList();
      }

      return right(reports);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
