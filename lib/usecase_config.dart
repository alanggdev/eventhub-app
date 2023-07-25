import 'package:eventhub_app/features/auth/data/datasources/auth_user_remote.dart';
import 'package:eventhub_app/features/auth/data/repositories/auth_user_repository_impl.dart';
import 'package:eventhub_app/features/auth/domain/usecases/google_login.dart';
import 'package:eventhub_app/features/auth/domain/usecases/login_user.dart';
import 'package:eventhub_app/features/auth/domain/usecases/logout.dart';
import 'package:eventhub_app/features/auth/domain/usecases/register_provider.dart';
import 'package:eventhub_app/features/auth/domain/usecases/register_user.dart';
import 'package:eventhub_app/features/auth/domain/usecases/update_user.dart';

import 'package:eventhub_app/features/event/data/datasources/event_remote.dart';
import 'package:eventhub_app/features/event/data/repositories/event_repository_impl.dart';
import 'package:eventhub_app/features/event/domain/usecases/create_event.dart';
import 'package:eventhub_app/features/event/domain/usecases/delete_event.dart';
import 'package:eventhub_app/features/event/domain/usecases/get_provider_events.dart';
import 'package:eventhub_app/features/event/domain/usecases/get_user_events.dart';
import 'package:eventhub_app/features/event/domain/usecases/remove_provider.dart';

import 'package:eventhub_app/features/provider/data/datasources/provider_remote.dart';
import 'package:eventhub_app/features/provider/data/repositories/provider_repository_impl.dart';
import 'package:eventhub_app/features/provider/domain/usecases/create_service.dart';
import 'package:eventhub_app/features/provider/domain/usecases/delete_service.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_category_providers.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_provider_by_id.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_provider_by_userid.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_provider_services.dart';
import 'package:eventhub_app/features/provider/domain/usecases/update_provider_data.dart';
import 'package:eventhub_app/features/provider/domain/usecases/update_service.dart';

import 'package:eventhub_app/features/chat/data/datasources/chat_remote.dart';
import 'package:eventhub_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:eventhub_app/features/chat/domain/usecases/create_chat_usecase.dart';
import 'package:eventhub_app/features/chat/domain/usecases/get_chat_usecase.dart';
import 'package:eventhub_app/features/chat/domain/usecases/get_message_usecase.dart';
import 'package:eventhub_app/features/chat/domain/usecases/init_socket_usecase.dart';
import 'package:eventhub_app/features/chat/domain/usecases/load_chats_usecase.dart';
import 'package:eventhub_app/features/chat/domain/usecases/send_message_usecase.dart';

import 'package:eventhub_app/features/notification/data/repositories/notif_repository_impl.dart';
import 'package:eventhub_app/features/notification/data/datasources/notif_remote.dart';
import 'package:eventhub_app/features/notification/domain/usecases/get_notifs.dart';
import 'package:eventhub_app/features/notification/domain/usecases/send_notif.dart';
import 'package:eventhub_app/features/notification/domain/usecases/response_notif.dart';

class UseCaseConfig {
  AuthUserDataSourceImpl? authUserDataSourceImpl;
  AuthUserRepositoryImpl? authUserRepositoryImpl;
  RegisterUserUseCase? registerUserUseCase;
  LoginUserUseCase? loginUserUseCase;
  RegisterProviderUseCase? registerProviderUseCase;
  GoogleLoginUseCase? googleLoginUseCase;
  UpdateUserUseCase? updateUserUseCase;
  LogOutUseCase? logOutUseCase;

  EventDataSourceImpl? eventDataSourceImpl;
  EventRepositoryImpl? eventRepositoryImpl;
  CreateEventUseCase? createEventUseCase;
  GetUserEventsUseCase? getUserEventsUseCase;
  DeleteEventUseCase? deleteEventUseCase;
  GetProviderEventsUseCase? getProviderEventsUseCase;
  RemoveProviderUseCase? removeProviderUseCase;

  ProviderDataSourceImpl? providerDataSourceImpl;
  ProviderRepositoryImpl? providerRepositoryImpl;
  GetCategoryProvidersUseCase? getCategoryProvidersUseCase;
  GetProviderServicesUseCase? getProviderServicesUseCase;
  GetProviderByIdUseCase? getProviderByIdUseCase;
  GetProviderByUseridUseCase? getProviderByUseridUseCase;
  UpdateProviderDataUseCase? updateProviderDataUseCase;
  CreateServiceUseCase? createServiceUseCase;
  DeleteServiceUseCase? deleteServiceUseCase;
  UpdateServiceUseCase? updateServiceUseCase;

  ChatsRepositoryImpl? chatsRepositoryImpl;
  ChatRemoteDataSourceImpl? chatsRemoteDataSourceImp;
  CreateChatUseCase? createChatUseCase;
  GetChatUseCase? getChatUseCase;
  GetMessageUseCase? getMessageUseCase;
  InitSocketUseCase? initSocketUseCase;
  LoadChatsUseCase? loadChatsUseCase; 
  SendMessageUseCase? sendMessageUseCase;

  NotifRepositoryImpl? notifRepositoryImpl;
  NotifDataSourceImpl? notifDataSourceImpl;
  GetNotifsUseCase? getNotifsUseCase;
  SendNotifUseCase? sendNotifUseCase;
  ResponseNotifUseCase? responseNotifUseCase;

  UseCaseConfig() {
    authUserDataSourceImpl = AuthUserDataSourceImpl();
    authUserRepositoryImpl = AuthUserRepositoryImpl(authUserDataSource: authUserDataSourceImpl!);
    registerUserUseCase = RegisterUserUseCase(authUserRepositoryImpl!);
    loginUserUseCase = LoginUserUseCase(authUserRepositoryImpl!);
    registerProviderUseCase = RegisterProviderUseCase(authUserRepositoryImpl!);
    googleLoginUseCase = GoogleLoginUseCase(authUserRepositoryImpl!);
    updateUserUseCase = UpdateUserUseCase(authUserRepositoryImpl!);
    logOutUseCase = LogOutUseCase(authUserRepositoryImpl!);

    eventDataSourceImpl = EventDataSourceImpl();
    eventRepositoryImpl = EventRepositoryImpl(eventDataSource: eventDataSourceImpl!);
    createEventUseCase = CreateEventUseCase(eventRepositoryImpl!);
    getUserEventsUseCase = GetUserEventsUseCase(eventRepositoryImpl!);
    deleteEventUseCase = DeleteEventUseCase(eventRepositoryImpl!);
    getProviderEventsUseCase = GetProviderEventsUseCase(eventRepositoryImpl!);
    removeProviderUseCase = RemoveProviderUseCase(eventRepositoryImpl!);

    providerDataSourceImpl = ProviderDataSourceImpl();
    providerRepositoryImpl = ProviderRepositoryImpl(providerDataSource: providerDataSourceImpl!);
    getCategoryProvidersUseCase = GetCategoryProvidersUseCase(providerRepositoryImpl!);
    getProviderServicesUseCase = GetProviderServicesUseCase(providerRepositoryImpl!);
    getProviderByIdUseCase = GetProviderByIdUseCase(providerRepositoryImpl!);
    getProviderByUseridUseCase = GetProviderByUseridUseCase(providerRepositoryImpl!);
    updateProviderDataUseCase = UpdateProviderDataUseCase(providerRepositoryImpl!);
    createServiceUseCase = CreateServiceUseCase(providerRepositoryImpl!);
    deleteServiceUseCase = DeleteServiceUseCase(providerRepositoryImpl!);
    updateServiceUseCase = UpdateServiceUseCase(providerRepositoryImpl!);

    chatsRemoteDataSourceImp = ChatRemoteDataSourceImpl();
    chatsRepositoryImpl = ChatsRepositoryImpl(chatRemoteDataSource: chatsRemoteDataSourceImp!);
    createChatUseCase = CreateChatUseCase(chatsRepositoryImpl!);
    getChatUseCase = GetChatUseCase(chatsRepositoryImpl!);
    getMessageUseCase = GetMessageUseCase(chatsRepositoryImpl!);
    initSocketUseCase = InitSocketUseCase(chatsRepositoryImpl!);
    loadChatsUseCase = LoadChatsUseCase(chatsRepositoryImpl!); 
    sendMessageUseCase = SendMessageUseCase(chatsRepositoryImpl!);

    notifDataSourceImpl = NotifDataSourceImpl();
    notifRepositoryImpl = NotifRepositoryImpl(notifDataSource: notifDataSourceImpl!);
    getNotifsUseCase = GetNotifsUseCase(notifRepositoryImpl!);
    sendNotifUseCase = SendNotifUseCase(notifRepositoryImpl!);
    responseNotifUseCase = ResponseNotifUseCase(notifRepositoryImpl!);
  }
}