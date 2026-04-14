import 'package:dartz/dartz.dart';
import 'package:grad_project/common/chat/data/chats_list_model.dart';
import 'package:grad_project/core/error/failure.dart';

abstract class ChatRepo {
  Future<Either<Failure,ChatListModel>>getChatsList(
    {
      required int pageIndex,required int pageSize , String? search
    }
  );
}