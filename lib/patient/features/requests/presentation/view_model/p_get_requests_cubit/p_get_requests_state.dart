part of 'p_get_requests_cubit.dart';

@immutable
sealed class PGetRequestsState {}

final class PGetRequestsInitial extends PGetRequestsState {}

final class PGetRequestsLoading extends PGetRequestsState {}

final class PGetRequestsSuccess extends PGetRequestsState {
  final List<PRequestData> requests;
  final bool isLoadingMore;

  PGetRequestsSuccess({required this.requests, required this.isLoadingMore});
}

final class PGetRequestsFailure extends PGetRequestsState {
  final String errmsg;

  PGetRequestsFailure({required this.errmsg});
}
