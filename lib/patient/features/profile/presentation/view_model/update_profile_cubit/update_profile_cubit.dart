import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/profile/data/patient_profile_model.dart';
import 'package:grad_project/patient/features/profile/repo/patient_profile_repo.dart';
import 'package:meta/meta.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this.patientRepo) : super(UpdateProfileInitial());
  final PatientProfileRepo patientRepo;
  bool loading = false;
  Future<void> updatePatProfile(
  String firstName,
  String lastName,
  String phoneNumber,
  File? image,
  bool isImageRemoved,
) async {
  emit(UpdateProfileLoading());

  final result = await patientRepo.updatePatientProfileData(
    FirstName: firstName,
    LastName: lastName,
    PhoneNumber: phoneNumber,
    Image: image,
    IsImageRemoved: isImageRemoved,
  );

  result.fold(
    (failure) => emit(UpdateProfilefailure()),
    (patientProfile) => emit(UpdateProfileSuccess(patientProfile)),
  );
}
  }

