import 'package:flutter/material.dart';

import 'package:eventhub_app/home.dart';
import 'package:eventhub_app/welcome.dart';
import 'package:eventhub_app/features/auth/presentation/pages/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/authScreen' : ((context) => const AuthScreen()),
        '/home' : ((context) => const HomeScreen())
      },
      home: const WelcomePage(),
    );
  }
}
