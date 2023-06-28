import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/welcome.dart';
import 'package:eventhub_app/features/auth/presentation/pages/auth_screen.dart';

import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventhub_app/features/provider/presentation/bloc/provider_bloc.dart';
import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';

import 'package:eventhub_app/usecase_config.dart';

UseCaseConfig usecaseConfig = UseCaseConfig();

void main() {
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
              registerProviderUseCase: usecaseConfig.registerProviderUseCase!),
        ),
        BlocProvider<EventBloc>(
          create: (BuildContext context) => EventBloc(
              createEventUseCase: usecaseConfig.createEventUseCase!,
              getUserEventsUseCase: usecaseConfig.getUserEventsUseCase!,
              deleteEventUseCase: usecaseConfig.deleteEventUseCase!),
        ),
        BlocProvider<ProviderBloc>(
          create: (BuildContext context) => ProviderBloc(
              getCategoryProviersUseCase: usecaseConfig.getCategoryProviersUseCase!),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {'/authScreen': ((context) => const AuthScreen())},
        home: const WelcomePage(),
      ),
    );
  }
}
