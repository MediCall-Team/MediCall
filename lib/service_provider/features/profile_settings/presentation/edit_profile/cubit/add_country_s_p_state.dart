// add_country_s_p_state.dart
sealed class AddCountrySPState {}

final class AddCountrySPInitial extends AddCountrySPState {}

final class AddCountrySPLoading extends AddCountrySPState {}

final class AddCountrySPSuccess extends AddCountrySPState {
  final String message;
  AddCountrySPSuccess(this.message);
}

final class AddCountrySPError extends AddCountrySPState {
  final String error;
  AddCountrySPError(this.error);
}
