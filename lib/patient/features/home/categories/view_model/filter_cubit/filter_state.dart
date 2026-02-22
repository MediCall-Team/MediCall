part of 'filter_cubit.dart';

@immutable

final class FilterState {
  final String? selectedGender;
  final String? selectedPriceRange;
  final String? selectedLocation;

  FilterState({this.selectedGender, this.selectedPriceRange, this.selectedLocation});

  // قائمة مساعدة لتحويل القيم لنصوص تعرض في الـ UI
  List<String> get activeFilters {
    return [
      if (selectedGender != null) selectedGender!,
      if (selectedPriceRange != null) selectedPriceRange!,
      if (selectedLocation != null) selectedLocation!,
    ];
  }
}