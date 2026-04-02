import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/patient/features/authentication/data/patient_user_model.dart';
import 'package:grad_project/patient/features/profile/data/patient_profile_model.dart';
import 'package:grad_project/patient/features/profile/repo/patient_profile_repo.dart';
import 'package:meta/meta.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this.patientRepo) : super(UpdateProfileInitial());
  final PatientProfileRepo patientRepo;
  bool loading = false;
 Future<void> updatePatProfile({
  required String firstName,
  required String lastName,
  required String phoneNumber,
  File? image,
  required bool isImageRemoved,
}) async {
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
    (patientProfile) async {
      final oldUser = await CacheHelper.getUser();
      if (oldUser == null) return;

      final updatedUser = PatientUserModel(
        id: oldUser.id,
        fullName:
            "${patientProfile.firstName} ${patientProfile.lastName}".trim(),
        email: oldUser.email,
        token: oldUser.token,
        role: oldUser.role,
        imageUrl: patientProfile.profilePictureUrl ?? "",
      );

      await CacheHelper.saveUser(updatedUser);

      emit(UpdateProfileSuccess(patientProfile));
    },
  );
}
}