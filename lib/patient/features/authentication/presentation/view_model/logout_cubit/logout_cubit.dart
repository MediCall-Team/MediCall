import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this.repo) : super(LogoutInitial());
  final PatienAuthRepo repo;
bool loading = false;

Future<void> logOut({required String deviceId}) async {
  loading = true;
  emit(LogoutLoading());

  final response = await repo.logOut(deviceId: deviceId);

  response.fold(
    (faliure) => emit(LogoutFailure(errorMsg: faliure.errorMsg)),
    (_) => emit(LogoutSuccess()),
  );

  loading = false;
}

}
