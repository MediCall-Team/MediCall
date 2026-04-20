import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_profile_model.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:grad_project/patient/features/home/categories/view_model/repo/MoreReviewRepo.dart';
import 'package:grad_project/patient/features/home/categories/view_model/repo/ReviewsModel.dart';
import 'package:meta/meta.dart';

part 'service_provider_profile_state.dart';

class ServiceProviderProfileCubit extends Cubit<ServiceProviderProfileState> {
  ServiceProviderProfileCubit(this.repo)
    : super(ServiceProviderProfileInitial());
  final CategoriesRepo repo;

  Future<void> getProviderProfile({required int id}) async {
    emit(ServiceProviderProfileLoading());
    var data = await repo.getProviderProfile(id: id);
    data.fold(
      (failure) {
        emit(ServiceProviderProfileFailure(errorMsg: failure.errorMsg));
      },
      (serviceProviderProfileData) {
        emit(
          ServiceProviderProfileSuccess(
            serviceProviderProfileData: serviceProviderProfileData,
          ),
        );
      },
    );
  }

}
