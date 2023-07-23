part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class SetInitialState extends NotificationEvent {}

class ResponseNotification extends NotificationEvent {
  final Notification notification;
  final String response;

  ResponseNotification({required this.notification, required this.response});
}

class SendNotification extends NotificationEvent {
  final Notification notification;

  SendNotification({required this.notification});
}

class GetNotifications extends NotificationEvent {
  final int userid;

  GetNotifications({required this.userid});
}