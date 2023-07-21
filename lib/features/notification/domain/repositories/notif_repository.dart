import 'package:eventhub_app/features/notification/domain/entities/notification.dart';

abstract class NotifRepository {
  Future<List<Notification>> getNotifications(int userid);
}