import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/profile/data/patient_profile_model.dart';
import 'package:grad_project/patient/features/profile/repo/patient_profile_repo.dart';
import 'package:meta/meta.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit(this.patientRepo) : super(GetProfileInitial());
  final PatientProfileRepo patientRepo;
    bool loading = false;
 Future<void> getPatProfile() async {
  loading = true;
  emit(GetProfileLoading());

  final result = await patientRepo.getPatientProfileData();

  result.fold(
    (failure) {
      loading = false;
      emit(GetProfileFailure());
    },
    (patientProfile) {
      loading = false;
      emit(GetProfileSuccess(patientProfile));
    },
  );
}
}
