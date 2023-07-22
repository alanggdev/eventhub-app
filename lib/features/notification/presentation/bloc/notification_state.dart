part of 'notification_bloc.dart';

abstract class NotificationState {}

class InitialState extends NotificationState {}

class LoadingNotifications extends NotificationState {}
class NotificationsLoaded extends NotificationState {
  final List<Notification> notifications;

  NotificationsLoaded({required this.notifications});
}

class Error extends NotificationState {
  final String error;

  Error({required this.error});
}