part of 'patient_record_cubit.dart';

@immutable
sealed class PatientRecordState {}

final class PatientRecordInitial extends PatientRecordState {}
final class PatientRecordLoading extends PatientRecordState {}
final class PatientRecordSuccess extends PatientRecordState {
    final List<ReportModel> reportsList;

  PatientRecordSuccess({required this.reportsList});

}
final class PatientRecordFailure extends PatientRecordState {
  final String errmsg;

  PatientRecordFailure({required this.errmsg});
}