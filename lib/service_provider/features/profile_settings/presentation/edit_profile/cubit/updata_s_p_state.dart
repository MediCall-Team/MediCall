import 'package:grad_project/service_provider/features/profile_settings/presentation/widgets/ServiceProfileModel.dart';

sealed class UpdataSPState {}

final class UpdataSPInitial extends UpdataSPState {}

final class UpdataSPLoading extends UpdataSPState {}

final class UpdataSPSuccess extends UpdataSPState {
  final ProviderProfileModel profile;

  UpdataSPSuccess(this.profile);
}

final class UpdataSPFailure extends UpdataSPState {
  final String errMessage;

  UpdataSPFailure(this.errMessage);
}
