import 'package:bloc/bloc.dart';
import 'package:grad_project/common/chat/data/chats_list_model.dart';
import 'package:grad_project/common/chat/repo/chat_repo.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/helper/pagination.dart';
import 'package:meta/meta.dart';

part 'chats_lits_state.dart';

class ChatsLitsCubit extends Cubit<ChatsLitsState> {
  ChatsLitsCubit(this.repo) : super(ChatsLitsInitial()) {
    initPagination();
  }

  final ChatRepo repo;
  late PaginationHelper<ChatData> pagination;
  List<ChatData> _allChats = [];
  int unReadChats = 0;
  String? _currentSearchQuery;

  void initPagination() {
    pagination = PaginationHelper<ChatData>(
      pageSize: 10,
      fetchPage: (pageIndex, pageSize) async {
        final result = await repo.getChatsList(
          pageIndex: pageIndex,
          pageSize: pageSize,
          search: _currentSearchQuery,
        );

        return result.fold(
          (failure) => throw failure,
          (data) {
            unReadChats = data.totalChatsWithUnreadMessages;
            return (data.paginatedChats.data, data.paginatedChats.count);
          },
        );
      },
    );
  }

  Future<void> searchChats(String? query) async {
    _currentSearchQuery = query;
    await loadFirstPage();
  }

  Future<void> loadFirstPage() async {
    pagination.reset();
    _allChats.clear();
    emit(ChatsLitsLoading());

    try {
      await pagination.loadNextPage();
      _allChats = List.from(pagination.items);

      emit(ChatsLitsSuccess(
        chatsList: _allChats,
        isLoadingMore: false,
      ));
    } catch (failure) {
      if (failure is Failure) {
        emit(ChatsLitsFailure(errorMsg: failure.errorMsg));
      } else {
        emit(ChatsLitsFailure(errorMsg: "حدث خطأ غير متوقع"));
      }
    }
  }

  Future<void> loadMore() async {
    if (!pagination.hasMore || pagination.isLoading) return;

    emit(ChatsLitsSuccess(
      chatsList: _allChats,
      isLoadingMore: true,
    ));

    try {
      await pagination.loadNextPage();
      _allChats = List.from(pagination.items);

      emit(ChatsLitsSuccess(
        chatsList: _allChats,
        isLoadingMore: false,
      ));
    } catch (failure) {
      if (failure is Failure) {
        emit(ChatsLitsFailure(errorMsg: failure.errorMsg));
      }
    }
  }

  void updateOrAddChat(ChatData chat) {
    final index = _allChats.indexWhere((item) => item.chatId == chat.chatId);

    if (index != -1) {
      _allChats.removeAt(index);
      _allChats.insert(0, chat);
    } else {
      _allChats.insert(0, chat);
    }

    emit(ChatsLitsSuccess(
      chatsList: List.from(_allChats),
      isLoadingMore: false,
    ));
  }
}