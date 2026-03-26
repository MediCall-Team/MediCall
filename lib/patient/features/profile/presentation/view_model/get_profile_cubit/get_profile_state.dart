part of 'get_profile_cubit.dart';

@immutable
sealed class GetProfileState {}

final class GetProfileInitial extends GetProfileState {}

final class GetProfileLoading extends GetProfileState {}

final class GetProfileSuccess extends GetProfileState {
  final PatientProfileModel profile;

  GetProfileSuccess(this.profile);
}

final class GetProfileFailure extends GetProfileState {}
