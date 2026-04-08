import 'package:bloc/bloc.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/helper/pagination.dart';
import 'package:grad_project/patient/features/requests/data/model/requests_model.dart';
import 'package:grad_project/patient/features/requests/repo/p_requests_repo.dart';
import 'package:meta/meta.dart';

part 'p_get_requests_state.dart';

class PGetRequestsCubit extends Cubit<PGetRequestsState> {
  PGetRequestsCubit(this.repo) : super(PGetRequestsInitial());
  final PRequestsRepo repo;

  late PaginationHelper<PRequestData> pagination;

  int? status;

  void initPagination() {
    pagination = PaginationHelper<PRequestData>(
      pageSize: 10,
      fetchPage: (pageIndex, pageSize) async {
        final result = await repo.patientGetRequests(pageIndex, pageSize, status);

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

    emit(PGetRequestsLoading());

    try {
      await pagination.loadNextPage();

      emit(
        PGetRequestsSuccess(requests: pagination.items, isLoadingMore: false),
      );
    } catch (failure) {
      emit(PGetRequestsFailure(errmsg: (failure as Failure).errorMsg));
    }
  }

  Future<void> loadMore() async {
    if (!pagination.hasMore || pagination.isLoading) return;

    emit(PGetRequestsSuccess(requests: pagination.items, isLoadingMore: true));

    try {
      await pagination.loadNextPage();

      emit(
        PGetRequestsSuccess(requests: pagination.items, isLoadingMore: false),
      );
    } catch (failure) {
      emit(PGetRequestsFailure(errmsg: (failure as Failure).errorMsg));
    }
  }
}
