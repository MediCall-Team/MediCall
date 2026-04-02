import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/services/noti/push_notification_services.dart';
import 'package:grad_project/patient/features/authentication/data/patient_user_model.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  final PatienAuthRepo authRepo;

  bool loading = false;

  Future<void> loginMethod({
    required String email,
    required String password,
  }) async {
    loading = true;
    emit(LoginLoading());

    var data = await authRepo.patientLogin(email: email, password: password);
    data.fold(
      (failure) {
        loading = false;
        emit(LoginFailure(errorMsg: failure.errorMsg));
      },
      (userModel) async {
        loading = false;
        // PatientUserModel patientUserModel = PatientUserModel.fromJson(
        //   user_model as  Map<String, dynamic>,
        // );

        //  await PushNotificationServices.syncTokenAfterLogin();
        // save in cach
        await sendToken(userModel);
        emit(LoginSuccess(userModel: userModel));
      },
    );
  }

  Future<void> sendToken(PatientUserModel userModel) async {
    await CacheHelper.saveUser(userModel); // الأول

    await PushNotificationServices.syncTokenAfterLogin(); // بعدين
  }
}
