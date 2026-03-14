sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final String msg;

  ForgetPasswordSuccess({required this.msg});
}

final class ForgetPasswordFailure extends ForgetPasswordState {
  final String errorMsg;

  ForgetPasswordFailure({required this.errorMsg});
}
