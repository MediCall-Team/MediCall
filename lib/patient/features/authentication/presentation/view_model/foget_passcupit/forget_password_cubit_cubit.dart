import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/foget_passcupit/forget_password_cubit_state.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.authRepo) : super(ForgetPasswordInitial());

  final PatienAuthRepo authRepo;

  Future<void> forgetPassword({required String email}) async {
    emit(ForgetPasswordLoading());

    var result = await authRepo.forgetPassword(email: email);

    result.fold(
      (failure) {
        emit(ForgetPasswordFailure(errorMsg: failure.errorMsg));
      },
      (msg) {
        emit(ForgetPasswordSuccess(msg: msg));
      },
    );
  }
}
