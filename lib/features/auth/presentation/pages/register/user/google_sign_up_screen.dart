import 'package:eventhub_app/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text_field.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/button.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class GoogleSignUpScreen extends StatefulWidget {
  final User user;
  const GoogleSignUpScreen({super.key, required this.user});

  @override
  State<GoogleSignUpScreen> createState() => _GoogleSignUpScreenState();
}

enum AccountTypes { normal, supplier }

class _GoogleSignUpScreenState extends State<GoogleSignUpScreen> {
  final fullnameController = TextEditingController();
  AccountTypes? accountType = AccountTypes.normal;
  User? user;
  bool termsAndConditions = false;

  @override
  void initState() {
    super.initState();
    unloadLogInState();
    loadData();
  }

  void unloadLogInState() {
    final authbloc = context.read<AuthBloc>();
    User userUnload = User(access: 'unload', refresh: 'unload', userinfo: 'unload');
    authbloc.add(UnloadState(unload: userUnload));
  }

  void loadData() {
    user = widget.user;
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
                Padding(
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
                                  'Bienvenido, por favor, completa tus datos para registrarte.',
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
                          textFieldMaxLength(context, Icons.person, 'Nombre completo', fullnameController, 35),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ListTile(
                                  title: const Text(
                                    'Usuario',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      color: ColorStyles.textPrimary2,
                                    ),
                                  ),
                                  leading: Radio<AccountTypes>(
                                    value: AccountTypes.normal,
                                    groupValue: accountType,
                                    onChanged: (AccountTypes? value) {
                                      setState(() {
                                        accountType = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: const Text(
                                    'Proveedor',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      color: ColorStyles.textPrimary2,
                                    ),
                                  ),
                                  leading: Radio<AccountTypes>(
                                    value: AccountTypes.supplier,
                                    groupValue: accountType,
                                    onChanged: (AccountTypes? value) {
                                      setState(() {
                                        accountType = value;
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
                              IconButton(
                                onPressed: () {
                                  tooltip(context);
                                },
                                icon: const Icon(Icons.help_outline,
                                    color: ColorStyles.textPrimary2,
                                    size: 22),
                              ),
                            ],
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
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: formButtonSignUpGoogle(
                            context,
                            user!,
                            accountType,
                            fullnameController,
                            context.read<AuthBloc>(),
                            termsAndConditions),
                      ),
                    ],
                  ),
                ),
                if (state is CompletingGoogleLogIn)
                  loadingWidget(context)
                else if (state is GoogleLogInCompleted)
                  FutureBuilder(
                    future: Future.delayed(Duration.zero, () async {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(state.user, 0)),
                        (route) => false,
                      );
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
