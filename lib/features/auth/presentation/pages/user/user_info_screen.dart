import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventhub_app/features/auth/presentation/pages/auth_screen.dart';
import 'package:eventhub_app/home.dart';
import 'package:eventhub_app/keys.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class UserInfoScreen extends StatefulWidget {
  final User user;
  const UserInfoScreen(this.user, {super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final nameController = TextEditingController();
  final info = NetworkInfo();
  String? ip;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.userinfo['full_name'];
    load();
  }

  Future<void> load() async {
    final address = await info.getWifiIP();
    setState(() {
      ip = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: ColorStyles.baseLightBlue,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 55,
              backgroundColor: ColorStyles.primaryBlue,
              elevation: 0,
              title: TextButton.icon(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorStyles.white,
                  size: 15,
                ),
                label: const Text(
                  'Regresar',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: ColorStyles.white,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  color: ColorStyles.primaryBlue,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorStyles.baseLightBlue,
                      border: Border.all(color: ColorStyles.baseLightBlue),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Mi cuenta',
                        style: TextStyle(
                          color: ColorStyles.primaryGrayBlue,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nombre completo',
                              style: TextStyle(
                                color: ColorStyles.primaryGrayBlue,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const Divider(color: ColorStyles.baseLightBlue),
                            Stack(
                              children: [
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.125),
                                        blurRadius: 5,
                                        offset: const Offset(0, 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                TextField(
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: ColorStyles.white,
                                    // labelText: widget.user.userinfo['full_name'],
                                    counterStyle: TextStyle(
                                      color: ColorStyles.secondaryColor3,
                                    ),
                                    hintStyle: TextStyle(
                                      color: ColorStyles.secondaryColor3,
                                      fontFamily: 'Inter',
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'IP: ${ip.toString()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorStyles.primaryGrayBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: ColorStyles.primaryBlue,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black,
                      elevation: 3,
                    ),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (nameController.text.trim().isNotEmpty) {
                        context.read<AuthBloc>().add(UpdateName(
                            user: widget.user,
                            fullName: nameController.text.trim()));
                      }
                    },
                    child: const Text(
                      'Guardar información',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: ColorStyles.warningCancel,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black,
                      elevation: 3,
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(DeleteUser(
                          username: widget.user.userinfo['username']));
                    },
                    child: const Text(
                      'Eliminar cuenta',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (state is UpdatingUser)
            loading(context)
          else if (state is UserUpdated)
            FutureBuilder(
              future: Future.delayed(Duration.zero, () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.remove('user');

                await prefs
                    .setString('user', convert.jsonEncode(state.user.userinfo))
                    .then((value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(state.user, 0),
                    ),
                    (route) => false,
                  );
                });
              }),
              builder: (context, snapshot) {
                return Container();
              },
            )
          else if (state is UserDeleted)
            FutureBuilder(
              future: Future.delayed(Duration.zero, () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.remove('user');

                IO.Socket? socket = IO.io(socketURL, IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

                await prefs.remove('access_token');
                await prefs.remove('refresh_token');
                await prefs.remove('user');

                socket.disconnect();

                await FirebaseMessaging.instance.deleteToken();

                final google = GoogleSignIn();
                google.signOut();

                Future.microtask((() {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ),
                    (route) => false,
                  );
                }));
              }),
              builder: (context, snapshot) {
                return Container();
              },
            )
        ],
      );
    });
  }
}
