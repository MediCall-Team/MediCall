import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/patient/features/notification/data/notification_model.dart';

abstract class NotiRepo {
  Future<Either<Failure,NotificationModel>>getMyNotifications({required
  int pageIndex,required int pageSize});

 Future<Either<Failure,int>>getMyNotificationsNumber();

 Future<Either<Failure,Unit>>readNotifications();
}