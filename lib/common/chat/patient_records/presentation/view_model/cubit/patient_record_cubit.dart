import 'package:bloc/bloc.dart';
import 'package:grad_project/common/chat/patient_records/repo/patient_record_repo.dart';
import 'package:grad_project/patient/features/profile/data/report_model.dart';
import 'package:meta/meta.dart';

part 'patient_record_state.dart';

class PatientRecordCubit extends Cubit<PatientRecordState> {
  PatientRecordCubit(this.repo) : super(PatientRecordInitial());
  final PatientRecordRepo repo;
  Future<void> getPtientRecord({required int patientId}) async {
    emit(PatientRecordLoading());
    var data = await repo.getReports(patientId: patientId);
    data.fold(
      (Failure) {
        emit(PatientRecordFailure(errmsg: Failure.errorMsg));
      },
      (reports) {
        emit(PatientRecordSuccess(reportsList: reports));
      },
    );
  }
}
