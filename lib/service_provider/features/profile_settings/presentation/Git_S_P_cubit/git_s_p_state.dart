import 'package:grad_project/service_provider/features/profile_settings/presentation/widgets/ServiceProfileModel.dart';

sealed class GitSPState {}

final class GitSPInitial extends GitSPState {}

final class GitSPLoading extends GitSPState {}

final class GitSPSuccess extends GitSPState {
  final ProviderProfileModel profile;
  GitSPSuccess(this.profile);
}

final class GitSPFailure extends GitSPState {
  final String errMessage;
  GitSPFailure(this.errMessage);
}
