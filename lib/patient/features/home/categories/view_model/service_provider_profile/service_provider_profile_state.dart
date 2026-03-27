part of 'service_provider_profile_cubit.dart';

@immutable
sealed class ServiceProviderProfileState {}

final class ServiceProviderProfileInitial extends ServiceProviderProfileState {}
final class ServiceProviderProfileSuccess extends ServiceProviderProfileState {
  final ServiceProviderProfileModel serviceProviderProfileData;

  ServiceProviderProfileSuccess({required this.serviceProviderProfileData});
}
final class ServiceProviderProfileFailure extends ServiceProviderProfileState {
  final String errorMsg;

  ServiceProviderProfileFailure({required this.errorMsg});
  
}
final class ServiceProviderProfileLoading extends ServiceProviderProfileState {}