import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState());

  void updateFilter(String category, String? value) {
    if (category == "النوع") {
      emit(FilterState(
        selectedGender: state.selectedGender == value ? null : value,
        selectedPriceRange: state.selectedPriceRange,
        selectedLocation: state.selectedLocation,
      ));
    } else if (category == "السعر") {
      emit(FilterState(
        selectedGender: state.selectedGender,
        selectedPriceRange: state.selectedPriceRange == value ? null : value,
        selectedLocation: state.selectedLocation,
      ));
    } else if (category == "المركز") {
      emit(FilterState(
        selectedGender: state.selectedGender,
        selectedPriceRange: state.selectedPriceRange,
        selectedLocation: state.selectedLocation == value ? null : value,
      ));
    }
  }

  void removeFilter(String value) {
    // نتحقق أي قيمة هي التي نود مسحها
    emit(FilterState(
      selectedGender: state.selectedGender == value ? null : state.selectedGender,
      selectedPriceRange: state.selectedPriceRange == value ? null : state.selectedPriceRange,
      selectedLocation: state.selectedLocation == value ? null : state.selectedLocation,
    ));
  }
}