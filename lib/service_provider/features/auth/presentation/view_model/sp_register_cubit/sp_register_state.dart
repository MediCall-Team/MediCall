part of 'sp_register_cubit.dart';

@immutable
sealed class SpRegisterState {}

final class SpRegisterInitial extends SpRegisterState {}

final class SpRegisterLoading extends SpRegisterState {}

final class SpRegisterSuccess extends SpRegisterState {}

final class SpRegisterFailure extends SpRegisterState {
  final String error;

  SpRegisterFailure(this.error);
}