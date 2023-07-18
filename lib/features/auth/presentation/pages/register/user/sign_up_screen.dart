import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/auth/presentation/pages/login/sign_in_screen.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/button.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text_field.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';

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
  bool termsAndConditions = false;

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
    User userUnload = User(access: 'unload', refresh: 'unload', userinfo: 'unload');
    authbloc.add(UnloadState(unload: userUnload));
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse('https://eventhub.fun/aviso-de-privacidad.html'), mode: LaunchMode.externalNonBrowserApplication)) {
      throw Exception('Could not launch https://eventhub.fun/aviso-de-privacidad.html');
    }
  }

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
                          height: MediaQuery.of(context).size.height * 0.15,
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
                                      width: 50,
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
                                    'Ingresa tus datos para registrarte.',
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
                            textFieldMaxLength(context, Icons.account_circle, 'Nombre de usuario', usernameController, 15),
                            textFieldMaxLength(context, Icons.person, 'Nombre completo', fullnameController, 35),
                            textField(context, Icons.email, 'Correo electrónico', emailController, TextInputType.text),
                            textFieldPass(context, Icons.lock, 'Contraseña', passController, hidePass, changePassVisibility),
                            textFieldPass(context, Icons.lock, 'Confirmar Contraseña', passConfirmController, hidePass, changePassVisibility),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'La contraseña debe tener entre 8 y 16 caracteres, y al menos una mayuscula.',
                                style: TextStyle(
                                  color: ColorStyles.textPrimary2,
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    title: const Text(
                                      'Usuario estandar',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  '¿No sabes que opción elegir? Pulsa en el icono',
                                  style: TextStyle(
                                    color: ColorStyles.textPrimary2,
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      tooltip(context);
                                    },
                                    child: const Icon(Icons.help_outline, color: ColorStyles.textPrimary2, size: 20),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: termsAndConditions,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        termsAndConditions = value!;
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      _launchUrl();
                                    },
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.7,
                                      child: RichText(
                                        text: const TextSpan(
                                          text: "Acepto los ",
                                            style: TextStyle(
                                            color: ColorStyles.textPrimary2,
                                            fontFamily: 'Inter',
                                            fontSize: 12,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "términos y condiciones",
                                                style: TextStyle(color: Color(0xffe73f6a), fontWeight: FontWeight.w600)),
                                            TextSpan(text: " de la aplicación "),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: formButtonSignUp(
                                  context,
                                  userType,
                                  usernameController,
                                  fullnameController,
                                  emailController,
                                  passController,
                                  passConfirmController,
                                  context.read<AuthBloc>(),
                                  termsAndConditions),
                            ),
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
                          ],
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
