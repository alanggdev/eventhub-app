import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/home.dart';

import 'package:eventhub_app/features/auth/presentation/pages/register/user/sign_up_screen.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/button.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text_field.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool hidePass = true;

  @override
  void initState() {
    super.initState();
    unloadLogInState();
  }

  changePassVisibility(bool state) {
    setState(() {
      hidePass = state;
    });
  }

  unloadLogInState() {
    final authbloc = context.read<AuthBloc>();
    User userUnload =
        User(access: 'unload', refresh: 'unload', userinfo: 'unload');
    authbloc.add(UnloadState(unload: userUnload));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.baseLightBlue,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      Images.logoURL,
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                    ),
                                    const Text(
                                      'eventhub',
                                      style: TextStyle(
                                        color: ColorStyles.textPrimary1,
                                        fontSize: 42,
                                        fontFamily: 'Righteous',
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Text(
                                    'Bienvenido, por favor, ingresa tus datos para iniciar sesión.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorStyles.textPrimary2,
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            textField(context, Icons.email, 'Correo electrónico', emailController, TextInputType.text),
                            textFieldPass(context, Icons.lock, 'Contraseña', passController, hidePass, changePassVisibility),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '¿No tienes una cuenta?',
                                      style: TextStyle(
                                        color: ColorStyles.secondaryColor3,
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpScreen()),
                                        );
                                      },
                                      child: const Text(
                                        'Regístrate',
                                        style: TextStyle(
                                            // color: Colors.black,
                                            color: ColorStyles.textPrimary2,
                                            fontFamily: 'Inter',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                formButtonSignIn(context, emailController,
                                    passController, context.read<AuthBloc>()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is LoggingInUser)
                  loadingWidget(context)
                else if (state is UserLoggedIn)
                  if (state.user.userinfo == 'error')
                    errorAlert(context, 'Verifique las credenciales de acceso')
                  else if (state.user.userinfo == 'unload')
                    Container()
                  else if ((state.user.userinfo != 'error'))
                    FutureBuilder(
                      future: Future.delayed(Duration.zero, () async {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(state.user, 0)),
                            (route) => false);
                      }),
                      builder: (context, snapshot) {
                        return Container();
                      },
                    )
              ],
            ),
          );
        },
      ),
    );
  }
}
