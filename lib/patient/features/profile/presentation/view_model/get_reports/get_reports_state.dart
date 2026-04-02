part of 'get_reports_cubit.dart';

@immutable
sealed class GetReportsState {}

final class GetReportsInitial extends GetReportsState {}
final class GetReportsLoading extends GetReportsState {}
final class GetReportsSuccess extends GetReportsState {
  final List<ReportModel> reportsList;

  GetReportsSuccess({required this.reportsList});

}
final class GetReportsFailure extends GetReportsState {
  final String errorMsg;

  GetReportsFailure({required this.errorMsg});
}