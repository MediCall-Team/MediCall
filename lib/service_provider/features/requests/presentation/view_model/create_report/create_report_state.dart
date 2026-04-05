part of 'create_report_cubit.dart';

@immutable
sealed class CreateReportState {}

final class CreateReportInitial extends CreateReportState {}

final class CreateReportLoading extends CreateReportState {}

final class CreateReportSuccess extends CreateReportState {
  final String message;

  CreateReportSuccess(this.message);
}

final class CreateReportFailure extends CreateReportState {
  final String errorMsg;

  CreateReportFailure(this.errorMsg);
}
