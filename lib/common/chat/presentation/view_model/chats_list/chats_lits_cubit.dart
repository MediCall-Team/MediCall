import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:grad_project/common/chat/data/chats_list_model.dart';
import 'package:grad_project/common/chat/presentation/view_model/messages_list/messages_list_cubit.dart';
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

        return result.fold((failure) => throw failure, (data) {
          unReadChats = data.totalChatsWithUnreadMessages;
          return (data.paginatedChats!.data, data.paginatedChats!.count);
        });
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

      emit(ChatsLitsSuccess(chatsList: _allChats, isLoadingMore: false));
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

    emit(ChatsLitsSuccess(chatsList: _allChats, isLoadingMore: true));

    try {
      await pagination.loadNextPage();
      _allChats = List.from(pagination.items);

      emit(ChatsLitsSuccess(chatsList: _allChats, isLoadingMore: false));
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

    emit(
      ChatsLitsSuccess(chatsList: List.from(_allChats), isLoadingMore: false),
    );
  }

  void markChatAsRead(int chatId) {
    final index = _allChats.indexWhere((c) => c.chatId == chatId);

    if (index == -1) return;

    final updatedChat = _allChats[index].copyWith(unreadCount: 0);

    _allChats[index] = updatedChat;

    log("Current list length: ${_allChats.length}");
    if (_allChats.isNotEmpty) {
      log("First Chat Last Message: ${_allChats.first.lastMessage}");
    }

    emit(
      ChatsLitsSuccess(chatsList: List.from(_allChats), isLoadingMore: false),
    );
  }

  void handleChatSummaryUpdate({
    required int chatId,
    String? lastMessage,
    DateTime? updatedAt,
    required int unreadCount,
  }) async {
    final index = _allChats.indexWhere((c) => c.chatId == chatId);

    //
    log("Current list length: ${_allChats.length}");
    if (_allChats.isNotEmpty) {
      log("First Chat Last Message: ${_allChats.first.lastMessage}");
    }
    //
    final old = _allChats[index];
    // 🟢 الحالة 1: موجود
    if (index != -1) {
      // final old = _allChats[index];

      final updated = old.copyWith(
        lastMessage: lastMessage ?? old.lastMessage,
        lastMessageDate: updatedAt ?? old.lastMessageDate,
        unreadCount: unreadCount,
      );

      _allChats[index] = updated;

      // 🔝 reorder (آخر رسالة تطلع فوق)
      _allChats.removeAt(index);
      _allChats.insert(0, updated);

      emit(
        ChatsLitsSuccess(chatsList: List.from(_allChats), isLoadingMore: false),
      );

      return;
    }

    // 🔴 الحالة 2: مش موجود → نجيب من API
    try {
      final result = await repo.getChatById(chatId: chatId);

      result.fold(
        (failure) {
          // ممكن ignore أو log
          log("error when try getChatById");
        },
        (chatById) {
          final newChat = ChatData(
            chatId: chatById.chatId,
            isClosed: chatById.isClosed,
            otherPersonId: chatById.otherPersonId,
            otherPersonName: chatById.otherPersonName,
            otherPersonImage: chatById.otherPersonImage ?? "",
            lastMessage: lastMessage ?? old.lastMessage,
            lastMessageDate: updatedAt ?? old.lastMessageDate,
            unreadCount: unreadCount,
          );

          _allChats.insert(0, newChat);

          emit(
            ChatsLitsSuccess(
              chatsList: List.from(_allChats),
              isLoadingMore: false,
            ),
          );
        },
      );
    } catch (e) {
      await loadFirstPage();
    }
  }

  void updateUnreadChatsBadge(int value) {
    unReadChats = value;

    emit(
      ChatsLitsSuccess(chatsList: List.from(_allChats), isLoadingMore: false),
    );
  }

  Future<void> toggleChat({
  required int chatId,
  required bool isClosed,
}) async {
  final index = _allChats.indexWhere((c) => c.chatId == chatId);
  if (index == -1) return;

  final old = _allChats[index];

  // 🔥 update local first
  final updated = old.copyWith(isClosed: !isClosed);
  _allChats[index] = updated;

  emit(ChatsLitsSuccess(
    chatsList: List.from(_allChats),
    isLoadingMore: false,
  ));

  try {
    if (isClosed) {
      await repo.openChat(chatId: chatId);
    } else {
      await repo.closeChat(chatId: chatId);
    }
  } catch (e) {
    // 🔥 rollback لو فشل
    _allChats[index] = old;

    emit(ChatsLitsSuccess(
      chatsList: List.from(_allChats),
      isLoadingMore: false,
    ));
  }
}

  void updateChatStatusFromSocket({
    required int chatId,
    required bool isClosed,
  }) {
        log("change chat state cubit ");

    final index = _allChats.indexWhere((c) => c.chatId == chatId);
    if (index == -1) return;

    final updated = _allChats[index].copyWith(isClosed: isClosed);

    _allChats[index] = updated;

      log("change chat state success cubit ${updated.chatId}");

    emit(
      ChatsLitsSuccess(chatsList: List.from(_allChats), isLoadingMore: false),
    );
  }
}
