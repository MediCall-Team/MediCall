part of 'create_request_cubit.dart';

@immutable
sealed class CreateRequestState {}

final class CreateRequestInitial extends CreateRequestState {}
final class CreateRequestLoading extends CreateRequestState {}
final class CreateRequestSuccess extends CreateRequestState {}
final class CreateRequestFailure extends CreateRequestState {
  final String errorMsg;

  CreateRequestFailure({required this.errorMsg});
  
}