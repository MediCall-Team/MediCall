import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';

class MessageModel2 {
  final String senderRole;
  final String messageText;

  MessageModel2({required this.senderRole, required this.messageText});

  Map<String, dynamic> toJson() => {
    "senderRole": senderRole,
    "messageText": messageText,
  };
}

abstract class AiRepository {
  Future<Either<Failure, String>> consult({
    required String newQuery,
    required List<MessageModel2> conversationHistory,
  });
}

class AiRepositoryImpl extends AiRepository {
  final ApiConsumer apiConsumer;

  AiRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, String>> consult({
    required String newQuery,
    required List<MessageModel2> conversationHistory,
  }) async {
    try {
      final response = await apiConsumer.post(
        "api/AiConsultation/consult",
        data: {
          "newQuery": newQuery,
          "conversationHistory": conversationHistory
              .map((e) => e.toJson())
              .toList(),
        },
      );

      final message = response["message"] as String;
      return Right(message);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
