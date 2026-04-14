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
  
  // الاحتفاظ بقيمة البحث الحالية
  String? _currentSearchQuery;

  void initPagination() {
    pagination = PaginationHelper<ChatData>(
      pageSize: 10,
      fetchPage: (pageIndex, pageSize) async {
        final result = await repo.getChatsList(
          pageIndex: pageIndex,
          pageSize: pageSize,
          search: _currentSearchQuery, // تمرير الـ query هنا
        );

        return result.fold(
          (failure) => throw failure,
          (data) => (data.paginatedChats.data, data.paginatedChats.count),
        );
      },
    );
  }

  // ميثود جديدة للبحث
  Future<void> searchChats(String? query) async {
    _currentSearchQuery = query;
    // لما نبحث، لازم نرجع نجيب أول صفحة ونمسح القديم
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
      // لو في بحث شغال، ممكن نختار منضيفش الشات الجديد إلا لو مطابق للبحث
      // لكن الأبسط نضفه ولما يعمل ريفريش الدنيا بتظبط
      _allChats.insert(0, chat);
    }

    emit(ChatsLitsSuccess(
      chatsList: List.from(_allChats),
      isLoadingMore: false,
    ));
  }
}