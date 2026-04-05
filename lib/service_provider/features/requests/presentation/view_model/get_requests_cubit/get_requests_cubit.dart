import 'package:bloc/bloc.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/helper/pagination.dart';
import 'package:grad_project/service_provider/features/requests/data/model/requests_model.dart';
import 'package:grad_project/service_provider/features/requests/repos/requests_repo.dart';
import 'package:meta/meta.dart';

part 'get_requests_state.dart';

class GetRequestsCubit extends Cubit<GetRequestsState> {
  GetRequestsCubit(this.repo) : super(GetRequestsInitial()) {
    initPagination();
  }

  final RequestsRepo repo;

  late PaginationHelper<RequestData> pagination;

  int? status;

  void initPagination() {
    pagination = PaginationHelper<RequestData>(
      pageSize: 10,
      fetchPage: (pageIndex, pageSize) async {
        final result = await repo.getAllRecuests(pageIndex, pageSize, status);

        return result.fold(
          (failure) => throw failure,
          (data) => (data.data, data.count),
        );
      },
    );
  }

  Future<void> loadFirstPage() async {
    // int? newStatus
    //status = newStatus;

    pagination.reset();

    emit(GetRequestsLoading());

    try {
      await pagination.loadNextPage();

      emit(
        GetRequestsSuccess(requests: pagination.items, isLoadingMore: false),
      );
    } catch (failure) {
      emit(GetRequestsFailure(errorMsg: (failure as Failure).errorMsg));
    }
  }

  Future<void> loadMore() async {
    if (!pagination.hasMore || pagination.isLoading) return;

    emit(GetRequestsSuccess(requests: pagination.items, isLoadingMore: true));

    try {
      await pagination.loadNextPage();

      emit(
        GetRequestsSuccess(requests: pagination.items, isLoadingMore: false),
      );
    } catch (failure) {
      emit(GetRequestsFailure(errorMsg: (failure as Failure).errorMsg));
    }
  }
  // في ملف get_requests_cubit.dart

  void removeRequest(int requestId) {
    final currentState = state;

    if (currentState is GetRequestsSuccess) {
      // حذف الطلب من القائمة
      final updatedRequests = List<RequestData>.from(currentState.requests)
        ..removeWhere((request) => request.requestId == requestId);

      // تحديث الحالة مع القائمة الجديدة
      emit(
        GetRequestsSuccess(
          requests: updatedRequests,
          isLoadingMore: currentState.isLoadingMore,
        ),
      );
    }
  }
}
