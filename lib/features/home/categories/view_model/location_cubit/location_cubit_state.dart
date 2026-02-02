part of 'location_cubit_cubit.dart';

@immutable
sealed class LocationCubitState {}

final class LocationCubitInitial extends LocationCubitState {}
final class LocationCubitLoading extends LocationCubitState {}
final class LocationCubitSuccess extends LocationCubitState {
  final List<LatLng> locations;

  LocationCubitSuccess({required this.locations});
}

final class LocationCubitFailure extends LocationCubitState {
  final String errorMsg;

  LocationCubitFailure({required this.errorMsg});
}