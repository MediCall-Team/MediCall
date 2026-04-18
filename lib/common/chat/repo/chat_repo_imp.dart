import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:grad_project/common/chat/data/chat_model_by_id.dart';
import 'package:grad_project/common/chat/data/chats_list_model.dart';
import 'package:grad_project/common/chat/data/message_model.dart';
import 'package:grad_project/common/chat/repo/chat_repo.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';

class ChatRepoImp implements ChatRepo{
  final ApiConsumer api;

  ChatRepoImp({required this.api});
  @override
  Future<Either<Failure, ChatListModel>> getChatsList({required int pageIndex, required int pageSize , String? search})async {
     try {
      var response = await api.get(
        "api/Chat/MyChats",
        queryParameters: {"pageIndex": pageIndex, "pageSize": pageSize ,
        "search":search
        },
      );

      return right(ChatListModel.fromJson(response));
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getChatMessages({required int chatId}) async{
         try {
      var response = await api.get(
        "api/Chat/$chatId/messages"
      );

    List<dynamic> data = response; 

    List<MessageModel> messagesList = data
        .map((element) => MessageModel.fromJson(element))
        .toList();

      return right(messagesList);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatModelById>> getChatById({required int chatId})async {
      try {
      var response = await api.get(
        "api/Chat/$chatId/metadata"
      );

      return right(ChatModelById.fromJson(response));
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
Future<Either<Failure, Unit>> closeChat({required int chatId}) async {
  try {
   var response= await api.put("api/Chat/$chatId/close");

log("STATUS CODE: ${response.statusCode}");
log("RESPONSE: ${response.data}");
    return right(unit);
  } on Failure catch (e) {
    return left(e);
  } catch (e) {
    return left(ServerFailure(e.toString()));
  }
}

@override
Future<Either<Failure, Unit>> openChat({required int chatId}) async {
  try {
    await api.put("api/Chat/$chatId/open"); // لو عندك endpoint تاني
    return right(unit);
  } on Failure catch (e) {
    return left(e);
  } catch (e) {
    return left(ServerFailure(e.toString()));
  }
}
}