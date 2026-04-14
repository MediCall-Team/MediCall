import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/patient/features/notification/data/notification_model.dart';
import 'package:grad_project/patient/features/notification/repo/noti_repo.dart';

class NotiRepoImp implements NotiRepo {
  final ApiConsumer api;
  NotiRepoImp({required this.api});

  @override
  Future<Either<Failure, NotificationModel>> getMyNotifications({
    required int pageIndex,
    required int pageSize,
  }) async {
    try {
      var response = await api.get(
        "api/Notifications/MyNotifications",
        queryParameters: {"pageIndex": pageIndex, "pageSize": pageSize},
      );

      return right(NotificationModel.fromJson(response));
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, int>> getMyNotificationsNumber() async{
   try {
      var response = await api.get(
        "api/Notifications/CountUnreadNotifications",
      );
      log("in repo imp noti number ${response["number"]}");
      return right(response["number"]);
    } on Failure catch (e) {
        log("in repo imp noti failure");
      return left(e);
    } catch (e) {
       log("in repo imp noti catch");
      return left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Unit>> readNotifications() async{
      try {
      await api.put(
        "api/Notifications/MarkAllAsRead",
       
      );

      return right(unit);
    } on Failure catch (e) {
      log("error in read notification ${e.errorMsg}");
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, int>> getMyNotificationsChatNumber() async{
     try {
      var response = await api.get(
        "api/Chat/UnreadMessagesCount",
      );

      return right(response["number"]);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
