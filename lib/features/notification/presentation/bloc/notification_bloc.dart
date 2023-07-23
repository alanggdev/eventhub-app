import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/notification/domain/entities/notification.dart';
import 'package:eventhub_app/features/notification/domain/usecases/get_notifs.dart';
import 'package:eventhub_app/features/notification/domain/usecases/response_notif.dart';
import 'package:eventhub_app/features/notification/domain/usecases/send_notif.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final ResponseNotifUseCase responseNotifUseCase;
  final SendNotifUseCase sendNotifUseCase;
  final GetNotifsUseCase getNotifsUseCase;

  NotificationBloc({
    required this.getNotifsUseCase,
    required this.sendNotifUseCase,
    required this.responseNotifUseCase,
  }) : super(InitialState()) {
    on<NotificationEvent>((event, emit) async {
      if (event is SetInitialState) {
        emit(InitialState());
      } else if (event is ResponseNotification) {
        try {
          emit(UpdatingNotificationStatus());
          String status = await responseNotifUseCase.execute(event.notification, event.response);
          emit(NotificationStatusUpdated(status: status));
        } catch (error) {
          emit(NotifError(error: error.toString()));
        }
      } else if (event is SendNotification) {
        try {
          emit(SendingNotification());
          String status = await sendNotifUseCase.execute(event.notification);
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
