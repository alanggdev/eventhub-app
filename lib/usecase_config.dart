import 'package:eventhub_app/features/auth/data/datasources/auth_user_remote.dart';
import 'package:eventhub_app/features/auth/data/repositories/auth_user_repository_impl.dart';
import 'package:eventhub_app/features/auth/domain/usecases/login_user.dart';
import 'package:eventhub_app/features/auth/domain/usecases/register_provider.dart';
import 'package:eventhub_app/features/auth/domain/usecases/register_user.dart';

import 'package:eventhub_app/features/event/data/datasources/event_remote.dart';
import 'package:eventhub_app/features/event/data/repositories/event_repository_impl.dart';
import 'package:eventhub_app/features/event/domain/usecases/create_event.dart';
import 'package:eventhub_app/features/event/domain/usecases/delete_event.dart';
import 'package:eventhub_app/features/event/domain/usecases/get_user_events.dart';

import 'package:eventhub_app/features/provider/data/datasources/provider_remote.dart';
import 'package:eventhub_app/features/provider/data/repositories/provider_repository_impl.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_category_providers.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_provider_services.dart';

class UseCaseConfig {
  AuthUserDataSourceImpl? authUserDataSourceImpl;
  AuthUserRepositoryImpl? authUserRepositoryImpl;
  RegisterUserUseCase? registerUserUseCase;
  LoginUserUseCase? loginUserUseCase;
  RegisterProviderUseCase? registerProviderUseCase;

  EventDataSourceImpl? eventDataSourceImpl;
  EventRepositoryImpl? eventRepositoryImpl;
  CreateEventUseCase? createEventUseCase;
  GetUserEventsUseCase? getUserEventsUseCase;
  DeleteEventUseCase? deleteEventUseCase;

  ProviderDataSourceImpl? providerDataSourceImpl;
  ProviderRepositoryImpl? providerRepositoryImpl;
  GetCategoryProvidersUseCase? getCategoryProvidersUseCase;
  GetProviderServicesUseCase? getProviderServicesUseCase;

  UseCaseConfig() {
    authUserDataSourceImpl = AuthUserDataSourceImpl();
    authUserRepositoryImpl = AuthUserRepositoryImpl(authUserDataSource: authUserDataSourceImpl!);
    registerUserUseCase = RegisterUserUseCase(authUserRepositoryImpl!);
    loginUserUseCase = LoginUserUseCase(authUserRepositoryImpl!);
    registerProviderUseCase = RegisterProviderUseCase(authUserRepositoryImpl!);

    eventDataSourceImpl = EventDataSourceImpl();
    eventRepositoryImpl = EventRepositoryImpl(eventDataSource: eventDataSourceImpl!);
    createEventUseCase = CreateEventUseCase(eventRepositoryImpl!);
    getUserEventsUseCase = GetUserEventsUseCase(eventRepositoryImpl!);
    deleteEventUseCase = DeleteEventUseCase(eventRepositoryImpl!);

    providerDataSourceImpl = ProviderDataSourceImpl();
    providerRepositoryImpl = ProviderRepositoryImpl(providerDataSource: providerDataSourceImpl!);
    getCategoryProvidersUseCase = GetCategoryProvidersUseCase(providerRepositoryImpl!);
    getProviderServicesUseCase = GetProviderServicesUseCase(providerRepositoryImpl!);
  }
}