part of 'update_request_cubit.dart';

@immutable
sealed class UpdateRequestState {}

final class UpdateRequestInitial extends UpdateRequestState {}
final class UpdateRequestLoading extends UpdateRequestState {}

final class UpdateRequestSuccess extends UpdateRequestState {}

final class UpdateRequestFailure extends UpdateRequestState {
  final String errorMsg;

  UpdateRequestFailure(this.errorMsg);
}

