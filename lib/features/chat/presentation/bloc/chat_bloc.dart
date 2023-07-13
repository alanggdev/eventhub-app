// ignore_for_file: library_prefixes
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:eventhub_app/features/chat/domain/entities/chat.dart';
import 'package:eventhub_app/features/chat/domain/entities/message.dart';
import 'package:eventhub_app/features/chat/domain/usecases/create_chat_usecase.dart';
import 'package:eventhub_app/features/chat/domain/usecases/get_chat_usecase.dart';
import 'package:eventhub_app/features/chat/domain/usecases/get_message_usecase.dart';
import 'package:eventhub_app/features/chat/domain/usecases/init_socket_usecase.dart';
import 'package:eventhub_app/features/chat/domain/usecases/load_chats_usecase.dart';
import 'package:eventhub_app/features/chat/domain/usecases/send_message_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final CreateChatUseCase createChatUseCase;
  final GetChatUseCase getChatUseCase;
  final GetMessageUseCase getMessageUseCase;
  final InitSocketUseCase initSocketUseCase;
  final LoadChatsUseCase loadChatsUseCase;
  final SendMessageUseCase sendMessageUseCase;

  ChatBloc({
    required this.createChatUseCase,
    required this.getChatUseCase,
    required this.getMessageUseCase,
    required this.initSocketUseCase,
    required this.loadChatsUseCase,
    required this.sendMessageUseCase,
  }) : super(InitialState()) {
    on<ChatEvent>((event, emit) async {
      if (event is LoadHomePage){
       try {
          emit(LoadingChats());
          final List<Chat>? chats = await loadChatsUseCase.execute(event.userId);
          if (chats != null){
            emit(LoadedChats(chats: chats));
          } else {
            emit(Error(error: 'Ocurrio un error cargando los chats'));
            await Future.delayed(const Duration(milliseconds: 2500), () {
              emit(InitialState());
            });
          }
       } catch (e) {
         emit(Error(error: e.toString()));
       }
      }

      else if (event is LoadChatPage){
        try {
          
          emit(LoadingChat());
          final Chat? chat = await getChatUseCase.execute(event.chatId);
           if (chat != null){
            emit(LoadedChat(chat: chat));
          } else {
            emit(Error(error: 'Ocurrio un error cargando los mensjaes'));
            await Future.delayed(const Duration(milliseconds: 2500), () {
              emit(InitialState());
            });
          }
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }

      else if (event is NewChatReceived){
        try {
          emit(LoadingChats());
          final List<Chat>? chats = await loadChatsUseCase.execute(event.userId);
          if (chats != null){
            emit(LoadedChats(chats: chats));
          } else {
            emit(Error(error: 'Ocurrio un error cargando los chats'));
            await Future.delayed(const Duration(milliseconds: 2500), () {
              emit(InitialState());
            });
          }
       } catch (e) {
         emit(Error(error: e.toString()));
       }
      }

      else if (event is NewMessageRceived){
        try {
          emit(LoadingMesage());
          final Message? msg = await getMessageUseCase.execute(event.userId, event.chatId);
          if (msg != null){
            emit(LoadedMessage(message: msg));
          } else {
            emit(Error(error: 'Ocurrio un error cargando los mensajaes'));
            await Future.delayed(const Duration(milliseconds: 2500), () {
              emit(InitialState());
            });
          }
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }

      else if (event is CreateChat){
        try {
          emit(LoadingChats());
          final bool created = await createChatUseCase.execute(
            event.message, event.sendBy, event.user1, event.user1Name, event.user2, event.user2Name
          );

          if (created == true){
            final List<Chat>? chats = await loadChatsUseCase.execute(event.sendBy);
            
            if (chats != null) {
              final String sendTo = event.sendBy == event.user1 ? event.user2 : event.user1;
              event.socketConn.emit('client:new-chat', sendTo);
              emit(LoadedChats(chats: chats));
            }
          } else{
            emit(Error(error: 'Ocurrio un error cargando los chats'));
            await Future.delayed(const Duration(milliseconds: 2500), () {
              emit(InitialState());
            });
          }
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }

      else if (event is SendMessage){
        try {
          emit(LoadingMesage());
          final bool sent = await sendMessageUseCase.execute(event.userId, event.chatId, event.message);
          if (sent == true){
            final Chat? chat = await getChatUseCase.execute(event.chatId);
            if (chat != null){
              event.socketConn.emit('client:new-message', event.sendTo);
              emit(LoadedChat(chat: chat));
            }
            // final Message? msg = await getMessageUseCase.execute(event.userId, event.chatId);
            // if (msg != null) {
            //   event.socketConn.emit('client:new-message', event.sendTo);
            //   emit(LoadedMessage(message: msg));
            // }
          }  else{
            emit(Error(error: 'Ocurrio un error cargando los mensajes'));
            await Future.delayed(const Duration(milliseconds: 2500), () {
              emit(InitialState());
            });
          }
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}