import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/notification/domain/entities/notification.dart';

import 'package:eventhub_app/features/notification/domain/usecases/get_notifs.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotifsUseCase getNotifsUseCase;

  NotificationBloc({
    required this.getNotifsUseCase
  }) : super(InitialState()) {
    on<NotificationEvent>(
      (event, emit) async {
        if (event is GetNotifications) {
          try {
            emit(LoadingNotifications());
            List<Notification> notifications = await getNotifsUseCase.execute(event.userid);
            emit(NotificationsLoaded(notifications: notifications));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        }
      }
    );
  }
}