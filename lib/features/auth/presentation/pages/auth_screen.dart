import 'package:flutter/material.dart';

import 'package:eventhub_app/features/auth/presentation/widgets/button.dart';
import 'package:eventhub_app/assets.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.baseLightBlue,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.logoURL,
                      width: MediaQuery.of(context).size.width * 0.22,
                    ),
                    const Text(
                      'eventhub',
                      style: TextStyle(
                        color: ColorStyles.textPrimary1,
                        fontSize: 55,
                        fontFamily: 'Righteous',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Image.asset(
                    Images.welcomeAuth,
                    width: MediaQuery.of(context).size.width * 0.85,
                  ),
                  const Text(
                    'La clave para tus eventos',
                    style: TextStyle(
                      color: ColorStyles.textPrimary2,
                      fontSize: 20,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    authButton(context ,'Correo'),
                    authButton(context ,'Google'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
