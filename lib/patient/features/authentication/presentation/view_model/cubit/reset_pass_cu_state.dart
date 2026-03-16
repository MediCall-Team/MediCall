sealed class ResetPassCuState {}

final class ResetPassCuInitial extends ResetPassCuState {}

final class ResetPassCuLoading extends ResetPassCuState {}

final class ResetPassCuSuccess extends ResetPassCuState {
  final String msg;
  ResetPassCuSuccess({required this.msg});
}

final class ResetPassCuFailure extends ResetPassCuState {
  final String errorMsg;
  ResetPassCuFailure({required this.errorMsg});
}
