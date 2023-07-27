part of 'notification_bloc.dart';

abstract class NotificationState {}

class InitialState extends NotificationState {}

class UpdatingNotificationStatus extends NotificationState {}
class NotificationStatusUpdated extends NotificationState {
  final String status;

  NotificationStatusUpdated({required this.status});
}

class SendingNotification extends NotificationState {}
class NotificationSent extends NotificationState {
  final String status;

  NotificationSent({required this.status});
}

class LoadingNotifications extends NotificationState {}
class NotificationsLoaded extends NotificationState {
  final List<Notification> notifications;

  NotificationsLoaded({required this.notifications});
}

class NotifError extends NotificationState {
  final String error;

  NotifError({required this.error});
}