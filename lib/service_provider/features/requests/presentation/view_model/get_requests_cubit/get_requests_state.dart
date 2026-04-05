part of 'get_requests_cubit.dart';

@immutable
sealed class GetRequestsState {}

final class GetRequestsInitial extends GetRequestsState {}

final class GetRequestsLoading extends GetRequestsState {}
final class GetRequestsFailure extends GetRequestsState {
    final String errorMsg;

  GetRequestsFailure({required this.errorMsg});
}
final class GetRequestsSuccess extends GetRequestsState {
   final List<RequestData> requests;
final bool isLoadingMore;

  GetRequestsSuccess({required this.requests, required this.isLoadingMore});
}