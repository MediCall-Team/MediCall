import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grad_project/core/utils/map_services.dart';
import 'package:meta/meta.dart';

part 'location_cubit_state.dart';

class LocationCubitCubit extends Cubit<LocationCubitState> {
  LocationCubitCubit() : super(LocationCubitInitial());

  Future<void> fetchLocations(List<String> places) async {
    if (isClosed) return;
    emit(LocationCubitLoading());

    try {
      final locations = await MapService.getLocationsFromNames(places);

      if (isClosed) return; // فحص هام جداً لمنع الـ Exception

      if (locations.isEmpty) {
        emit(LocationCubitFailure(errorMsg: "لم يتم العثور على أي موقع"));
      } else {
        emit(LocationCubitSuccess(locations: locations));
      }
    } catch (e) {
      if (isClosed) return;
      emit(LocationCubitFailure(errorMsg: e.toString()));
    }
  }
}
