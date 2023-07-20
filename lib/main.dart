import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:eventhub_app/usecase_config.dart';
import 'package:eventhub_app/welcome.dart';

import 'package:eventhub_app/features/auth/presentation/pages/auth_screen.dart';

import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventhub_app/features/provider/presentation/bloc/provider_bloc.dart';
import 'package:eventhub_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';

UseCaseConfig usecaseConfig = UseCaseConfig();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(
              registerUserUseCase: usecaseConfig.registerUserUseCase!,
              loginUserUseCase: usecaseConfig.loginUserUseCase!,
              registerProviderUseCase: usecaseConfig.registerProviderUseCase!,
              googleLoginUseCase: usecaseConfig.googleLoginUseCase!,
              updateUserUseCase: usecaseConfig.updateUserUseCase!,
              logOutUseCase: usecaseConfig.logOutUseCase!),
        ),
        BlocProvider<EventBloc>(
          create: (BuildContext context) => EventBloc(
              createEventUseCase: usecaseConfig.createEventUseCase!,
              getUserEventsUseCase: usecaseConfig.getUserEventsUseCase!,
              deleteEventUseCase: usecaseConfig.deleteEventUseCase!),
        ),
        BlocProvider<ProviderBloc>(
          create: (BuildContext context) => ProviderBloc(
              getCategoryProvidersUseCase: usecaseConfig.getCategoryProvidersUseCase!,
              getProviderServicesUseCase: usecaseConfig.getProviderServicesUseCase!,
              getProviderByIdUseCase: usecaseConfig.getProviderByIdUseCase!,
              getProviderByUseridUseCase: usecaseConfig.getProviderByUseridUseCase!,
              updateProviderDataUseCase: usecaseConfig.updateProviderDataUseCase!,
              createServiceUseCase: usecaseConfig.createServiceUseCase!,
              deleteServiceUseCase: usecaseConfig.deleteServiceUseCase!,
              updateServiceUseCase: usecaseConfig.updateServiceUseCase!),
        ),
        BlocProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(
            createChatUseCase: usecaseConfig.createChatUseCase!,
            getChatUseCase: usecaseConfig.getChatUseCase!,
            getMessageUseCase: usecaseConfig.getMessageUseCase!,
            initSocketUseCase: usecaseConfig.initSocketUseCase!,
            loadChatsUseCase: usecaseConfig.loadChatsUseCase!,
            sendMessageUseCase: usecaseConfig.sendMessageUseCase!
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/authScreen': ((context) => const AuthScreen())
        },
        home: const WelcomePage(),
      ),
    );
  }
}
