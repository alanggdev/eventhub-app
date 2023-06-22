import 'package:flutter/material.dart';

import 'package:eventhub_app/home.dart';
import 'package:eventhub_app/welcome.dart';

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
        '/home' : ((context) => const HomeScreen())
      },
      home: const WelcomePage(),
    );
  }
}
