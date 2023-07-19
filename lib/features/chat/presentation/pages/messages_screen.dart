// ignore_for_file: library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:eventhub_app/features/chat/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/chat/presentation/pages/chat_screen.dart';
import 'package:eventhub_app/features/chat/domain/entities/chat.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class MessagesScreen extends StatefulWidget {
  final User user;
  final IO.Socket? socketConn;
  const MessagesScreen(this.user, this.socketConn, {super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  User? user;
  List<Chat>? chats = [];
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    initSocket();
    createChat();
  }

  void initSocket() {
    if (widget.socketConn != null) {
      if (widget.socketConn!.active) {
        context.read<ChatBloc>().add(LoadHomePage(userId: widget.user.userinfo['pk'].toString()));

        widget.socketConn!.on('server:new-chat', (data) {
          // print("Nuevo chat recibido");
          if (data == widget.user.userinfo['pk'].toString()) {
            if (isActive) {
              context.read<ChatBloc>().add(NewChatReceived(userId: widget.user.userinfo['pk'].toString()));
            }
          }
        });

        widget.socketConn!.on('server:load-messages', (data) {
          // print("Nuevo mensaje recibido desde mensajes");
          if (data == widget.user.userinfo['pk'].toString()) {
            if (isActive) {
              context.read<ChatBloc>().add(LoadHomePage(userId: widget.user.userinfo['pk'].toString()));
            }
          }
        });
      } else {
        chats = null;
      }
    } else {
      chats = null;
    }

    widget.socketConn?.onError((err) {
      chats = null;
    });
  }

  Future<void> createChat() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('providerUserId')) {
      int? providerUserId = prefs.getInt('providerUserId');
      String? providerName = prefs.getString('providerName');
      prefs.remove('providerUserId');
      prefs.remove('providerName');

      if (providerUserId != null && providerName != null) {
        Future.microtask((() {
          context.read<ChatBloc>().add(CreateChat(
                socketConn: widget.socketConn!,
                message:
                    "Hola, me gustaría obtener más información sobre sus servicios.",
                sendBy: widget.user.userinfo['pk'].toString(),
                user1: widget.user.userinfo['pk'].toString(),
                user1Name: widget.user.userinfo['full_name'].toString(),
                user2: providerUserId.toString(),
                user2Name: providerName,
              ));
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: ColorStyles.baseLightBlue,
        body: SingleChildScrollView(
          child: Column(
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
                      'Mis mensajes',
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
              if (chats == null) 
                errorWidget(context, 'No fue posible cargar los chats. Inténtelo más tarde.'),
              if (state is LoadingChats || state is InitialState && chats != null)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: loadingChatWidget(context),
                ),
              if (state is! LoadedChats && chats != null && state is! LoadingChats)
                if (chats!.isNotEmpty)
                  Column(
                    children: chats!.map(
                      (chat) {
                        return chatWidget(context, chat);
                      },
                    ).toList(),
                ),
              if (state is LoadedChats && chats!.isEmpty)
                  emptyWidget(context, 'No tienes mensajes', Images.emptychat),
              if (state is LoadedChats)
                if (state.chats!.isNotEmpty)
                FutureBuilder(
                  future: Future.delayed(Duration.zero, () async {
                    setState(() {
                      chats = state.chats!;
                    });
                  }),
                  builder: (context, snapshot) {
                    return Column(
                      children: state.chats!.map((chat) {
                          return chatWidget(context, chat);
                        },
                      ).toList(),
                    );
                  },
                )
            ],
          ),
        ),
      );
    });
  }

  Padding chatWidget(BuildContext context, Chat chat) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isActive = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                  widget.user,
                  chat.id!,
                  widget.user.userinfo['pk'].toString(),
                  chat.user1 != widget.user.userinfo['pk'].toString()
                      ? chat.user1!
                      : chat.user2!,
                  chat.user1 != widget.user.userinfo['pk'].toString()
                      ? chat.user1Name!
                      : chat.user2Name!,
                  widget.socketConn!),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorStyles.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                blurRadius: 5,
                offset: const Offset(0, 0.5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.user.userinfo['pk'].toString() == chat.user1
                          ? chat.user2Name!
                          : chat.user1Name!,
                        //chat.user2Name,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: ColorStyles.textPrimary2),
                      ),
                      Text(
                        chat.messages!.last.timeStamp,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            color: ColorStyles.textSecondary1),
                      ),
                    ],
                  ),
                ),
                Text(
                  chat.messages!.last.sendBy == widget.user.userinfo['pk'].toString()
                      ? 'Tú: ${chat.messages!.last.message}'
                      : chat.messages!.last.message,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      color: ColorStyles.textSecondary1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
