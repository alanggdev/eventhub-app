import 'package:eventhub_app/features/notification/domain/usecases/send_notif.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/notification/domain/entities/notification.dart';
import 'package:eventhub_app/features/notification/domain/usecases/get_notifs.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final SendNotifUseCase sendNotifUseCase;
  final GetNotifsUseCase getNotifsUseCase;

  NotificationBloc({
    required this.getNotifsUseCase,
    required this.sendNotifUseCase,
  }) : super(InitialState()) {
    on<NotificationEvent>((event, emit) async {
      if (event is SetInitialState) {
        emit(InitialState());
      } else  if (event is SendNotification) {
        try {
          emit(SendingNotification());
          String status = await sendNotifUseCase.execute(event.notification, event.receiverToken);
          emit(NotificationSent(status: status));
        } catch (error) {
          emit(NotifError(error: error.toString()));
        }
      } else if (event is GetNotifications) {
        try {
          emit(LoadingNotifications());
          List<Notification> notifications = await getNotifsUseCase.execute(event.userid);
          emit(NotificationsLoaded(notifications: notifications));
        } catch (error) {
          emit(NotifError(error: error.toString()));
        }
      }
    });
  }
}
