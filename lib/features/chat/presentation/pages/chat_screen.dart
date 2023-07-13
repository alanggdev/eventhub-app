// ignore_for_file: library_prefixes
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/home.dart';

import 'package:eventhub_app/features/chat/presentation/bloc/chat_bloc.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  final String chatId;
  final String userId;
  final String receptorId;
  final String nameAppbar;
  final IO.Socket socketConn;
  const ChatScreen(this.user, this.chatId, this.userId, this.receptorId,
      this.nameAppbar, this.socketConn,
      {super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final IO.Socket socket = IO.io(socketURL, IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());
  
  @override
  void initState() {
    super.initState();
    connectSocket();
    context.read<ChatBloc>().add(LoadChatPage(chatId: widget.chatId));
  }

  void connectSocket() {
    print('connect socket');
    widget.socketConn.on('server:load-messages', (data) {
      print("Nuevo mensaje recibido desde chat");
      if (data == widget.userId) {
        context.read<ChatBloc>().add(LoadChatPage(chatId: widget.chatId));
      }
    });
  }

  // @override
  // void dispose() {
  //   widget.socketConn.dispose();
  //   print('dispose chat');
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return WillPopScope(
        onWillPop: () async {
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomeScreen(widget.user, 2)),
          //   (Route<dynamic> route) => false,
          // );
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: ColorStyles.primaryBlue,
          body: SafeArea(
            child: Container(
              color: ColorStyles.baseLightBlue,
              child: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: 70,
                    backgroundColor: ColorStyles.primaryBlue,
                    title: TextButton.icon(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: ColorStyles.white,
                        size: 15,
                      ),
                      label: Text(
                        widget.nameAppbar,
                        style: const TextStyle(
                          fontSize: 23,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: ColorStyles.white,
                        ),
                      ),
                      onPressed: () {
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => HomeScreen(widget.user, 2)),
                        //   (Route<dynamic> route) => false,
                        // );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
                body: Column(
                  children: [
                    Container(
                      decoration:
                          const BoxDecoration(color: ColorStyles.primaryBlue),
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                          color: ColorStyles.baseLightBlue,
                          border: Border.all(
                            color: ColorStyles.baseLightBlue,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                        ),
                        child: Column(
                          children: [
                            if (state is LoadingChat || state is LoadingMesage)
                              const Text(
                                'Cargando ...',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: ColorStyles.textPrimary2,
                                    fontWeight: FontWeight.w500),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (state is LoadedChat)
                      if (state.chat != null && state.chat!.messages.isNotEmpty)
                        Column(
                          children: state.chat!.messages.map(
                            (msg) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                child: Align(
                                  alignment: msg.sendBy == widget.userId
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      decoration: BoxDecoration(
                                        color: msg.sendBy == widget.userId
                                            ? ColorStyles.primaryBlue.withOpacity(0.85)
                                            : ColorStyles.secondaryColor1.withOpacity(0.85),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.45,
                                              child: Text(
                                                msg.message,
                                                style: const TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: ColorStyles.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                msg.timeStamp,
                                                style: const TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: ColorStyles.white,
                                                  fontSize: 10
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 80,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  hintText: "Mensaje...",
                                  filled: true,
                                  fillColor: Color(0xffD9D9D9),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {},
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                                backgroundColor: ColorStyles.primaryBlue
                              ),
                              child: const Icon(Icons.attach_file),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                context.read<ChatBloc>().add(SendMessage(socketConn: widget.socketConn, userId: widget.userId, chatId: widget.chatId, message: messageController.text, sendTo: widget.receptorId));
                                messageController.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                                backgroundColor: ColorStyles.primaryBlue
                              ),
                              child: const Icon(Icons.send),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
