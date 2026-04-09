part of 'request_management_cubit.dart';

@immutable
abstract class RequestManagementState {}

class RequestManagementInitial extends RequestManagementState {}

class RequestManagementLoading extends RequestManagementState {
  final int requestId;

  RequestManagementLoading(this.requestId);
}

class RequestManagementSuccess extends RequestManagementState {
  final int requestId;
  final String message;

  RequestManagementSuccess(this.message, this.requestId);
}

class RequestManagementFailure extends RequestManagementState {
  final String errorMsg;
  final int requestId;

  RequestManagementFailure(this.errorMsg, this.requestId);
}