part of 'notification_number_cubit.dart';

@immutable
sealed class NotificationNumberState {}

final class NotificationNumberInitial extends NotificationNumberState {}
final class NotificationNumberSuccess extends NotificationNumberState {
  final int number;

  NotificationNumberSuccess({required this.number});
}

final class NotificationChatNumberSuccess extends NotificationNumberState {
  final int chatNumber;

  NotificationChatNumberSuccess({required this.chatNumber});
}