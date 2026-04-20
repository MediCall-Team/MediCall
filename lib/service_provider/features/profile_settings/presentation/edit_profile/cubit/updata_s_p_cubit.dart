import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/cubit/updata_s_p_state.dart';
import 'package:grad_project/service_provider/features/requests/repos/Service_profile_Repo.dart';
import 'package:meta/meta.dart';

class UpdataSPCubit extends Cubit<UpdataSPState> {
  final SPProfileRepo repo;

  UpdataSPCubit(this.repo) : super(UpdataSPInitial());

  List<int> _areaIds = [];

  void setAreas(List<int> ids) {
    _areaIds = ids;
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required double latitude,
    required double longitude,
    required double price,
    required bool isActive,
    required String bio,
    File? image,
  }) async {
    emit(UpdataSPLoading());

    final body = {
      "FirstName": firstName,
      "LastName": lastName,
      "PhoneNumber": phoneNumber,
      "Latitude": latitude,
      "Longitude": longitude,
      "Price": price,
      "IsActive": isActive,
      "Description": bio,
      "ProfileImage": image,
      "AreaIds": _areaIds, // ✅ استخدم اللي اتخزن
    };

  if(_areaIds.isNotEmpty){
  log("areas is not empty");
  }
  else{
     log("areas is empty");
  }
    

    final result = await repo.updateProviderProfile(body);

    result.fold(
      (failure) => emit(UpdataSPFailure(failure.errorMsg)),
      (profile) => emit(UpdataSPSuccess(profile)),
    );
  }
}
