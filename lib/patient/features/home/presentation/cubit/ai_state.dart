import 'package:grad_project/patient/features/home/presentation/repo/AiRepositoryImpl.dart';

sealed class AiState {}

final class AiInitial extends AiState {}

final class AiLoading extends AiState {}

final class AiSuccess extends AiState {
  final String botReply;
  final List<MessageModel2> conversationHistory;

  AiSuccess({required this.botReply, required this.conversationHistory});
}

final class AiFailure extends AiState {
  final String errorMsg;

  AiFailure({required this.errorMsg});
}
