part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class SetInitialState extends NotificationEvent {}

class SendNotification extends NotificationEvent {
  final Notification notification;
  final String receiverToken;

  SendNotification({required this.notification, required this.receiverToken});
}

class GetNotifications extends NotificationEvent {
  final int userid;

  GetNotifications({required this.userid});
}