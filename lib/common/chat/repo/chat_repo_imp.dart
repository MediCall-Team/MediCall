import 'package:dartz/dartz.dart';
import 'package:grad_project/common/chat/data/chats_list_model.dart';
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

  
}