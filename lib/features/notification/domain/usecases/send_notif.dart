import 'package:eventhub_app/features/notification/domain/entities/notification.dart';
import 'package:eventhub_app/features/notification/domain/repositories/notif_repository.dart';

class SendNotifUseCase {
  final NotifRepository notifRepository;

  SendNotifUseCase(this.notifRepository);

  Future<String> execute(Notification notification) async {
    return await notifRepository.sendNotification(notification);
  }
}
