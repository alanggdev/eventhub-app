import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import 'package:eventhub_app/home.dart';
import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/auth/presentation/pages/auth_screen.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    splash();
  }

  Future<void> splash() async {
    User? user = await verifySession();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          // pageBuilder: (context, animation, secondaryAnimation) => const AuthScreen(),
          pageBuilder: (context, animation, secondaryAnimation) {
            return user == null ? const AuthScreen() : HomeScreen(user, 0);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 2.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
        (route) => false,
      ),
    );
  }

  Future<User?> verifySession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('access_token');
    final String? refreshToken = prefs.getString('refresh_token');
    final String? userInfo = prefs.getString('user');
    if (accessToken != null && refreshToken != null && userInfo != null) {
      dynamic user = convert.jsonDecode(userInfo);
      User userData = User(access: accessToken, refresh: refreshToken, userinfo: user);
      return userData;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.baseLightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Image.asset(
                // 'assets/images/logo.png',
                Images.logoURL,
                width: 190,
              ),
            ),
          ),
          const Text(
            'eventhub',
            style: TextStyle(
              color: ColorStyles.textPrimary1,
              fontSize: 50,
              fontFamily: 'Righteous',
            ),
          ),
        ],
      ),
    );
  }
}
