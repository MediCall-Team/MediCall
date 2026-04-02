import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/notification/repo/noti_repo.dart';
import 'package:meta/meta.dart';

part 'notification_number_state.dart';

class NotificationNumberCubit extends Cubit<NotificationNumberState> {
  NotificationNumberCubit(this.repo) : super(NotificationNumberInitial());
  final NotiRepo repo;
  int number = 0;
  bool _isFetching = false;

  Future<void> getMyNotificationsNumber() async {
    if (_isFetching) return; 

    _isFetching = true;
    var data = await repo.getMyNotificationsNumber();

    data.fold(
      (failure) {
        log("can't receive notifications ${failure.errorMsg}");
      },
      (num) {
        number = num;
        emit(NotificationNumberSuccess(number: num));
      },
    );
    _isFetching = false;
  }

  // ميثود قراءة الإشعارات وتصفير العدد
  Future<void> readNotifications() async {
    // 1. تصفير محلي سريع للـ UI
    number = 0;
    emit(NotificationNumberSuccess(number: 0));

    // 2. إبلاغ السيرفر
    var result = await repo.readNotifications();
    
    result.fold(
      (failure) => log("Error marking notifications as read: ${failure.errorMsg}"),
      (success) async {
        // 3. تأكيد العدد النهائي من السيرفر بعد التحديث
        await getMyNotificationsNumber();
      },
    );
  }
}
