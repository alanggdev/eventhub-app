import 'package:eventhub_app/features/notification/data/datasources/notif_remote.dart';
import 'package:eventhub_app/features/notification/domain/entities/notification.dart';
import 'package:eventhub_app/features/notification/domain/repositories/notif_repository.dart';

class NotifRepositoryImpl implements NotifRepository {
  final NotifDataSource notifDataSource;

  NotifRepositoryImpl({required this.notifDataSource});

  @override
  Future<List<Notification>> getNotifications(int userid) async {
    return await notifDataSource.getNotifications(userid);
  }
}