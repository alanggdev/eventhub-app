import 'package:eventhub_app/features/auth/data/datasources/auth_user_remote.dart';
import 'package:eventhub_app/features/auth/data/repositories/auth_user_repository_impl.dart';
import 'package:eventhub_app/features/auth/domain/usecases/login_user.dart';
import 'package:eventhub_app/features/auth/domain/usecases/register_user.dart';

import 'package:eventhub_app/features/event/data/datasources/event_remote.dart';
import 'package:eventhub_app/features/event/data/repositories/event_repository_impl.dart';
import 'package:eventhub_app/features/event/domain/usecases/create_event.dart';
import 'package:eventhub_app/features/event/domain/usecases/get_user_events.dart';

class UseCaseConfig {
  AuthUserDataSourceImpl? authUserDataSourceImpl;
  AuthUserRepositoryImpl? authUserRepositoryImpl;
  RegisterUserUseCase? registerUserUseCase;
  LoginUserUseCase? loginUserUseCase;

  EventDataSourceImpl? eventDataSourceImpl;
  EventRepositoryImpl? eventRepositoryImpl;
  CreateEventUseCase? createEventUseCase;
  GetUserEventsUseCase? getUserEventsUseCase;

  UseCaseConfig() {
    authUserDataSourceImpl = AuthUserDataSourceImpl();
    authUserRepositoryImpl = AuthUserRepositoryImpl(authUserDataSource: authUserDataSourceImpl!);
    registerUserUseCase = RegisterUserUseCase(authUserRepositoryImpl!);
    loginUserUseCase = LoginUserUseCase(authUserRepositoryImpl!);

    eventDataSourceImpl = EventDataSourceImpl();
    eventRepositoryImpl = EventRepositoryImpl(eventDataSource: eventDataSourceImpl!);
    createEventUseCase = CreateEventUseCase(eventRepositoryImpl!);
    getUserEventsUseCase = GetUserEventsUseCase(eventRepositoryImpl!);
  }
}