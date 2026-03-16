import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/cubit/reset_pass_cu_state.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';

class ResetPassCuCubit extends Cubit<ResetPassCuState> {
  final PatienAuthRepo authRepo;

  ResetPassCuCubit(this.authRepo) : super(ResetPassCuInitial());

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    emit(ResetPassCuLoading());
    var result = await authRepo.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
    result.fold(
      (failure) => emit(ResetPassCuFailure(errorMsg: failure.errorMsg)),
      (msg) => emit(ResetPassCuSuccess(msg: msg)),
    );
  }
}
