part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class GetNotifications extends NotificationEvent {
  final int userid;

  GetNotifications({required this.userid});
}