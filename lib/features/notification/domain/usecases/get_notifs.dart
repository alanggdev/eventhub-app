import 'package:eventhub_app/features/notification/domain/entities/notification.dart';
import 'package:eventhub_app/features/notification/domain/repositories/notif_repository.dart';

class GetNotifsUseCase {
  final NotifRepository notifRepository;

  GetNotifsUseCase(this.notifRepository);

  Future<List<Notification>> execute(int userid) async {
    return await notifRepository.getNotifications(userid);
  }
}
