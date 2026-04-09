// add_country_s_p_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/cubit/add_country_s_p_state.dart';
import 'package:meta/meta.dart';
import 'package:grad_project/service_provider/features/requests/repos/Service_profile_Repo.dart';
import 'package:grad_project/core/error/failure.dart';

class AddCountrySPCubit extends Cubit<AddCountrySPState> {
  final SPProfileRepo repo;

  AddCountrySPCubit(this.repo) : super(AddCountrySPInitial());

  Future<void> addAreas(List<int> areaIds) async {
    emit(AddCountrySPLoading());
    final result = await repo.addAreas(areaIds);
    result.fold(
      (failure) => emit(AddCountrySPError(failure.errorMsg)),
      (successMessage) => emit(AddCountrySPSuccess(successMessage)),
    );
  }
}
