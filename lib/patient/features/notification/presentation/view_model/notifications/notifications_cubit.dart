import 'package:bloc/bloc.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/helper/pagination.dart';
import 'package:grad_project/patient/features/notification/data/notification_model.dart';
import 'package:grad_project/patient/features/notification/repo/noti_repo.dart';
import 'package:meta/meta.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.repo) : super(NotificationsInitial()) {
    initPagination(); // بننادي عليها هنا أول ما الـ Cubit يتكريت
  }
  
  final NotiRepo repo;
  late PaginationHelper<NotificationData> pagination;

  void initPagination() {
    pagination = PaginationHelper<NotificationData>(
      pageSize: 10,
      fetchPage: (pageIndex, pageSize) async {
        final result = await repo.getMyNotifications(
          pageIndex: pageIndex,
          pageSize: pageSize,
        );

        return result.fold(
          (failure) => throw failure,
          (data) => (data.data ?? [], data.count ?? 0),
        );
      },
    );
  }

  Future<void> loadFirstPage() async {
    pagination.reset();
    emit(NotificationsLoading());

    try {
      await pagination.loadNextPage();
      emit(NotificationsSuccess(
        notificationList: pagination.items,
        isLoadingMore: false,
      ));
    } catch (failure) {
      emit(NotificationsFailure(errorMsg: (failure as Failure).errorMsg));
    }
  }

  Future<void> loadMore() async {
    if (!pagination.hasMore || pagination.isLoading) return;

    emit(NotificationsSuccess(
      notificationList: pagination.items,
      isLoadingMore: true,
    ));

    try {
      await pagination.loadNextPage();
      emit(NotificationsSuccess(
        notificationList: pagination.items,
        isLoadingMore: false,
      ));
    } catch (failure) {
      emit(NotificationsFailure(errorMsg: (failure as Failure).errorMsg));
    }
  }
}
