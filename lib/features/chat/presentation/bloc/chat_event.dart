part of 'chat_bloc.dart';

abstract class ChatEvent {}

class UnloadMessages extends ChatEvent {}

class LoadHomePage extends ChatEvent {
  final String userId;
  LoadHomePage({required this.userId});
}

class NewChatReceived extends ChatEvent {
  final String userId;
  NewChatReceived({required this.userId});
}

class LoadChatPage extends ChatEvent {
  final String chatId;
  LoadChatPage({required this.chatId});
}

class NewMessageRceived extends ChatEvent {
  final String userId;
  final String chatId;
  NewMessageRceived({required this.userId, required this.chatId});
}

class CreateChat extends ChatEvent {
  final IO.Socket socketConn;
  final String message;
  final String sendBy;
  final String user1;
  final String user1Name;
  final String user2;
  final String user2Name;
  CreateChat({
    required this.socketConn,
    required this.message,
    required this.sendBy,
    required this.user1,
    required this.user1Name,
    required this.user2,
    required this.user2Name,
  });
}

class SendMessage extends ChatEvent {
  final IO.Socket socketConn;
  final String userId;
  final String chatId;
  final String message;
  final String sendTo;
  SendMessage(
      {required this.socketConn,
      required this.userId,
      required this.chatId,
      required this.message,
      required this.sendTo});
}
