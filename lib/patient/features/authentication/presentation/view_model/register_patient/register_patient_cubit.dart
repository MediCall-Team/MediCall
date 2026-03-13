import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';
import 'package:meta/meta.dart';
part 'register_patient_state.dart';

class RegisterPatientCubit extends Cubit<RegisterPatientState> {
  RegisterPatientCubit(this.authRepo) : super(RegisterPatientInitial());

  final PatienAuthRepo authRepo;

  Future<void> patientRegisterMethod({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    File? image,
  }) async {
    emit(RegisterPatientLoading());

    var data = await authRepo.patientRegister(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      image: image,
    );
    data.fold(
      (failure) {
        emit(RegisterPatientFailure(errorMsg: failure.errorMsg));
      },
      (msg) {
        emit(RegisterPatientSuccess(msg: msg));
      },
    );
  }
}
