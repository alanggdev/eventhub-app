// ignore_for_file: library_prefixes
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/home.dart';
import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:eventhub_app/features/chat/domain/entities/message.dart';
import 'package:eventhub_app/features/chat/domain/entities/chat.dart';

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
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  bool available = true;
  bool isActive = true;

  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket() {
    context.read<ChatBloc>().add(LoadChatPage(chatId: widget.chatId));

    widget.socketConn.on('server:new-message', (data) {
      // print("Nuevo mensaje recibido desde chat");
      if (data == widget.userId) {
        if (isActive) {
          context.read<ChatBloc>().add(LoadChatPage(chatId: widget.chatId));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return WillPopScope(
        onWillPop: () async {
          // ignore: invalid_use_of_visible_for_testing_member
          context.read<ChatBloc>().emit(LoadedChat(chat: Chat(messages: [])));
          setState(() {
            isActive = false;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(widget.user, 2)),
            (Route<dynamic> route) => false,
          );
          // Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: ColorStyles.baseLightBlue,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            elevation: 0,
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
                // ignore: invalid_use_of_visible_for_testing_member
                context.read<ChatBloc>().emit(LoadedChat(chat: Chat(messages: [])));
                setState(() {
                  isActive = false;
                });
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(widget.user, 2)),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: ColorStyles.primaryBlue),
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
                        Text( state is LoadingChat ? 
                          'Cargando ...' : 'Enviando ...',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              color: ColorStyles.textPrimary2,
                              fontWeight: FontWeight.w500),
                        ),
                    ],
                  ),
                ),
              ),
              if (state is LoadingChat || state is LoadingMesage)
                if (messages.isNotEmpty)
                  Expanded(
                    child: ListView(
                      reverse: true,
                      children: messages.reversed.map(
                        (msg) {
                          return messageWidget(msg, context);
                        },
                      ).toList(),
                    ),
                  )
                else
                  Expanded(child: Container()),
              if (state is LoadedChat)
                if (state.chat != null && state.chat!.messages!.isNotEmpty)
                  FutureBuilder(
                    future: Future.delayed(Duration.zero, () async {
                      setState(() {
                        messages = state.chat!.messages!;
                      });
                    }),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: ListView(
                          reverse: true,
                          children: messages.reversed.map(
                            (msg) {
                              return messageWidget(msg, context);
                            },
                          ).toList(),
                        ),
                      );
                    },
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: ColorStyles.primaryBlue),
                        child: const Icon(Icons.attach_file),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (available && messageController.text.trim().isNotEmpty) {
                            setState(() {
                              available = !available;
                            });
                            context.read<ChatBloc>().add(SendMessage(
                                socketConn: widget.socketConn,
                                userId: widget.userId,
                                chatId: widget.chatId,
                                message: messageController.text,
                                sendTo: widget.receptorId));
                            await Future.delayed(const Duration(milliseconds: 500));
                            messageController.clear();
                            setState(() {
                              available = !available;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: available && messageController.text.trim().isNotEmpty
                              ? ColorStyles.primaryBlue
                              : ColorStyles.primaryGrayBlue
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
      );
    });
  }

  Padding messageWidget(Message msg, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Align(
        alignment: msg.sendBy == widget.userId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.5
            ),
          child: Container(
              // width: MediaQuery.of(context).size.width * 0.5,
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
                    Padding(
                      padding: const EdgeInsets.only(right: 12, left: 5),
                      child: Text(
                        msg.message,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            color: ColorStyles.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                    Text(
                      msg.timeStamp,
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          color: ColorStyles.white,
                          fontSize: 10),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
