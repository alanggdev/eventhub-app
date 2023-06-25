import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/home.dart';
import 'package:eventhub_app/welcome.dart';
import 'package:eventhub_app/features/auth/presentation/pages/auth_screen.dart';
import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';
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
              loginUserUseCase: usecaseConfig.loginUserUseCase!),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/authScreen': ((context) => const AuthScreen()),
          '/home': ((context) => const HomeScreen())
        },
        home: const WelcomePage(),
      ),
    );
  }
}
