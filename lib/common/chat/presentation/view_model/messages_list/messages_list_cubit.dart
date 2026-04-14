import 'package:bloc/bloc.dart';
import 'package:grad_project/common/chat/data/message_model.dart';
import 'package:grad_project/common/chat/repo/chat_repo.dart';
import 'package:meta/meta.dart';

part 'messages_list_state.dart';

class MessagesListCubit extends Cubit<MessagesListState> {
  MessagesListCubit(this.repo) : super(MessagesListInitial());

  final ChatRepo repo;
  List<MessageModel> allMessages = [];

  Future<void> getChatMessages({required int chatId}) async {
    emit(MessagesListLoading());

    var data = await repo.getChatMessages(chatId: chatId);
    
    data.fold(
      (failure) {
        emit(MessagesListFailure(errorMsg: failure.errorMsg));
      }, 
      (messages) {
        allMessages = messages; 
        
        emit(MessagesListSuccess(messagesList: List.from(allMessages)));
      },
    );
  }

  // ميثود إضافية ستحتاجها عند التعامل مع SignalR لإضافة رسالة واحدة فوراً
  void addLocalMessage(MessageModel newMessage) {
    allMessages.add(newMessage);
    // نرسل الحالة الجديدة بالقائمة المحدثة ليتم إعادة بناء الـ UI
    emit(MessagesListSuccess(messagesList: List.from(allMessages)));
  }
}
