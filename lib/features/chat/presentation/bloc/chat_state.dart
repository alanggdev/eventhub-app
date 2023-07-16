part of 'chat_bloc.dart';

abstract class ChatState {}

class InitialState extends ChatState {}

class LoadingChats extends ChatState {}

class LoadingChat extends ChatState {}

class LoadingMesage extends ChatState {}

class LoadedChats extends ChatState {
  final List<Chat>? chats;
  LoadedChats({required this.chats});
}

class LoadedChat extends ChatState {
  final Chat? chat;
  LoadedChat({required this.chat});
}

class LoadedMessage extends ChatState {
  final Message? message;
  LoadedMessage({required this.message});
}

class Error extends ChatState {
  final String error;
  Error({required this.error});
}
