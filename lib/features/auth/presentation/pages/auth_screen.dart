import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/home.dart';

import 'package:eventhub_app/features/auth/presentation/pages/register/user/google_sign_up_screen.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/button.dart';
import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.baseLightBlue,
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return SafeArea(
          child: Stack(
            children: [
              Column(
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
                          authButton(context, 'Correo', null),
                          authButton(context, 'Google', context.read<AuthBloc>()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (state is ConnectingGoogle)
                loading(context)
              else if (state is GoogleConnected)
                if (state.user.userinfo == 'unload')
                  Container()
                else
                  FutureBuilder(
                    future: Future.delayed(Duration.zero, () async {
                      if (state.user.userinfo['is_provider'] == null) {
                        // print('need to complete sign up process');
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoogleSignUpScreen(user: state.user)),
                          (route) => false);
                      } else {
                        // print('redirecting to home');
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(state.user, 0)),
                          (route) => false);
                      }
                    }),
                    builder: (context, snapshot) {
                      return Container();
                    },
                  )
            ],
          ),
        );
      }),
    );
  }
}
