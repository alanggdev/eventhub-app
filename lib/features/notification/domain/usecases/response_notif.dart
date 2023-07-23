import 'package:eventhub_app/features/notification/domain/entities/notification.dart';
import 'package:eventhub_app/features/notification/domain/repositories/notif_repository.dart';

class ResponseNotifUseCase {
  final NotifRepository notifRepository;

  ResponseNotifUseCase(this.notifRepository);

  Future<String> execute(Notification notification, String response) async {
    return await notifRepository.responseNotification(notification, response);
  }
}
