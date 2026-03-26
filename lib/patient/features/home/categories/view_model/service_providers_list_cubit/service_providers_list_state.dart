part of 'service_providers_list_cubit.dart';

@immutable
sealed class ServiceProvidersListState {}

final class ServiceProvidersListInitial extends ServiceProvidersListState {}
final class ServiceProvidersListLoading extends ServiceProvidersListState {}

final class ServiceProvidersListSuccess extends ServiceProvidersListState {
  final List<DoctorModel> doctorSModelList;
  final bool isLoadingMore;

  ServiceProvidersListSuccess({
    required this.doctorSModelList,
    this.isLoadingMore = false,
  });
}
final class ServiceProvidersListFaliure extends ServiceProvidersListState {
  final String errorMsg;

  ServiceProvidersListFaliure({required this.errorMsg});

}