import 'package:eventhub_app/features/notification/domain/entities/notification.dart';

abstract class NotifRepository {
  Future<List<Notification>> getNotifications(int userid);
  Future<String> sendNotification(Notification notification);
  Future<String> responseNotification(Notification notification, String response);
}