import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/home/presentation/cubit/ai_state.dart';
import 'package:grad_project/patient/features/home/presentation/repo/AiRepositoryImpl.dart';

class AiCubit extends Cubit<AiState> {
  final AiRepository aiRepository;

  final List<MessageModel2> _conversationHistory = [];

  List<MessageModel2> get conversationHistory =>
      List.unmodifiable(_conversationHistory);

  AiCubit({required this.aiRepository}) : super(AiInitial());

  Future<void> consult(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    _conversationHistory.add(
      MessageModel2(senderRole: "user", messageText: userMessage),
    );

    emit(AiLoading());

    final result = await aiRepository.consult(
      newQuery: userMessage,
      conversationHistory: _conversationHistory.length > 1
          ? _conversationHistory.sublist(0, _conversationHistory.length - 1)
          : [],
    );

    result.fold(
      (failure) {
        _conversationHistory.removeLast();
        emit(AiFailure(errorMsg: failure.errorMsg));
      },
      (message) {
        _conversationHistory.add(
          MessageModel2(senderRole: "assistant", messageText: message),
        );
        emit(
          AiSuccess(
            botReply: message,
            conversationHistory: List<MessageModel2>.from(_conversationHistory),
          ),
        );
      },
    );
  }

  void reset() {
    _conversationHistory.clear();
    emit(AiInitial());
  }
}
