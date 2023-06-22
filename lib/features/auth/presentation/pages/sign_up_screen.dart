import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/button.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

enum UserTypes { normal, supplier }

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();
  UserTypes? userType = UserTypes.normal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.baseLightBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          // reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
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
                              width: MediaQuery.of(context).size.width * 0.15,
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
                              horizontal: 45, vertical: 10),
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
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: Column(
                    children: [
                      textFieldForm(
                          context, Icons.person, 'Nombre', nameController),
                      textFieldForm(context, Icons.email, 'Correo electrónico',
                          emailController),
                      textFieldForm(
                          context, Icons.lock, 'Contraseña', passController),
                      textFieldForm(context, Icons.lock, 'Confirmar Contraseña',
                          passConfirmController),
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
                                  color: Color(0xffCC9BAC),
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
                          formButtonSignUp(context, userType),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
