import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/auth/presentation/widgets/alerts.dart';
import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/button.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text_field.dart';
import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventhub_app/features/auth/presentation/pages/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

enum UserTypes { normal, supplier }

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();
  UserTypes? userType = UserTypes.normal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorStyles.baseLightBlue,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return SafeArea(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: double.infinity,
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
                                    'Bienvenido, por favor, ingresa tus datos para registrarte.',
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55,
                          width: double.infinity,
                          child: Column(
                            children: [
                              textFieldMaxLength(context, Icons.person, 'Nombre de usuario', usernameController, 15),
                              textFieldMaxLength(context, Icons.person, 'Nombre completo', fullnameController, 35),
                              textField(context, Icons.email, 'Correo electrónico', emailController, TextInputType.text),
                              textFieldPass(context, Icons.lock, 'Contraseña', passController),
                              textFieldPass(context, Icons.lock, 'Confirmar Contraseña', passConfirmController),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        'Usuario normal',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          color: ColorStyles.textPrimary2,
                                        ),
                                      ),
                                      leading: Radio<UserTypes>(
                                        value: UserTypes.normal,
                                        groupValue: userType,
                                        onChanged: (UserTypes? value) {
                                          setState(() {
                                            userType = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        'Organizador Proveedor',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          color: ColorStyles.textPrimary2,
                                        ),
                                      ),
                                      leading: Radio<UserTypes>(
                                        value: UserTypes.supplier,
                                        groupValue: userType,
                                        onChanged: (UserTypes? value) {
                                          setState(() {
                                            userType = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        '¿Ya tienes una cuenta?',
                                        style: TextStyle(
                                          color: ColorStyles.secondaryColor3,
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Inicia Sesión',
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
                                  formButtonSignUp(
                                      context,
                                      userType,
                                      usernameController,
                                      fullnameController,
                                      emailController,
                                      passController,
                                      passConfirmController,
                                      context.read<AuthBloc>()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is CreatingUser)
                  loadingWidget(context)
                else if (state is UserCreated)
                  FutureBuilder(
                    future: Future.delayed(Duration.zero, () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
                    }),
                    builder: (context, snapshot) {
                      return Container();
                    },
                  )
                else if (state is Error)
                  errorAlert(context, state.error)
              ]),
            );
          },
        ));
  }
}
