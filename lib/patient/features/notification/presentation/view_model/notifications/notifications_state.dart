part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}
final class NotificationsLoading extends NotificationsState {}
final class NotificationsSuccess extends NotificationsState {
  final List<NotificationData> notificationList;
final bool isLoadingMore;
  NotificationsSuccess({required this.notificationList,  this.isLoadingMore=false});
}
final class NotificationsFailure extends NotificationsState {
  final String errorMsg;

  NotificationsFailure({required this.errorMsg});
}