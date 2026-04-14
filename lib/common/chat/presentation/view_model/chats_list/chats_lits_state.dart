part of 'chats_lits_cubit.dart';

@immutable
sealed class ChatsLitsState {}

final class ChatsLitsInitial extends ChatsLitsState {}
final class ChatsLitsLoading extends ChatsLitsState {}
final class ChatsLitsFailure extends ChatsLitsState {
  final String errorMsg;

  ChatsLitsFailure({required this.errorMsg});
}
final class ChatsLitsSuccess extends ChatsLitsState {
  final bool isLoadingMore;
  final List<ChatData> chatsList;

  ChatsLitsSuccess({required this.isLoadingMore, required this.chatsList});
}