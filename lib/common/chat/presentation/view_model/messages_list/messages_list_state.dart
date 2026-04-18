part of 'messages_list_cubit.dart';

@immutable
sealed class MessagesListState {}

final class MessagesListInitial extends MessagesListState {}
final class MessagesListSuccess extends MessagesListState {
  final List<MessageModel> messagesList;

  MessagesListSuccess({required this.messagesList});
}
final class MessagesListLoading extends MessagesListState {}
final class MessagesListFailure extends MessagesListState {
  final String errorMsg;

  MessagesListFailure({required this.errorMsg});
}

