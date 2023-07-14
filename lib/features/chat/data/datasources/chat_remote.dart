// ignore_for_file: library_prefixes

import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:eventhub_app/keys.dart';
import 'package:eventhub_app/features/chat/domain/entities/chat.dart';
import 'package:eventhub_app/features/chat/domain/entities/message.dart';

abstract class ChatRemoteDataSource {
  Future<List<Chat>?> getChatList(String userId);
  Future<Chat?> getChat(String id);
  Future<Message?> getMessage(String userId, String chatId);
  Future<bool> updateChat(String userId, String chatId, String message);
  Future<bool> createChat(String message, String sendBy, String user1,
      String user1Name, String user2, String user2Name);
  Future<void> initSocket();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final dio = Dio();
  late IO.Socket socket;

  @override
  Future<List<Chat>?> getChatList(String userId) async {
    late List<Chat> chats = [];
    try {
      Response res = await dio.get('$socketURL/chats/list/$userId');
      if (res.statusCode == 200) {
        var chatsList = res.data;
        if (chatsList.length > 0) {
          for (var object in chatsList) {
            var messagesJson = object['messages'];
            List<Message> messages = [];

            for (var messageJson in messagesJson) {
              var message = Message(
                message: messageJson['message'],
                sendBy: messageJson['sendBy'].toString(),
                timeStamp: messageJson['timeStamp'],
              );
              messages.add(message);
            }
            var chat = Chat(
              id: object['id'].toString(),
              messages: messages,
              user1: object['user1'].toString(),
              user1Name: object['username1'].toString(),
              user2: object['user2'].toString(),
              user2Name: object['username2'].toString(),
            );
            chats.add(chat);
          }
        }
        return chats;
      }
    } catch (e) {
      // print(e);
      throw Exception(e.toString());
    }
    return null;
  }

  @override
  Future<Chat?> getChat(String id) async {
    try {
      Response res = await dio.get('$socketURL/chats/$id');
      if (res.statusCode == 200) {
        //print(res.data);
        var messagesJson = res.data['messages'];
        List<Message> messages = [];
        for (var messageJson in messagesJson) {
          var message = Message(
            message: messageJson['message'],
            sendBy: messageJson['sendBy'].toString(),
            timeStamp: messageJson['timeStamp'],
          );
          messages.add(message);
        }
        return Chat(
          id: res.data['id'].toString(),
          messages: messages,
          user1: res.data['user1'].toString(),
          user1Name: res.data['username1'].toString(),
          user2: res.data['user2'].toString(),
          user2Name: res.data['username1'].toString(),
        );
      }
    } catch (e) {
      // print(e);
      throw Exception(e.toString());
    }
    return null;
  }

  @override
  Future<Message?> getMessage(String userId, String chatId) async {
    try {
      Response res = await dio.get('$socketURL/chats/msg/',
          data: {'userID': userId, 'chatId': chatId});
      if (res.statusCode == 200) {
        // print(res.data);
        return Message(
            message: res.data['message'],
            sendBy: res.data['sendBy'],
            timeStamp: res.data['timeStamp']);
      }
    } catch (e) {
      // print(e);
      throw Exception(e.toString());
    }
    return null;
  }

  @override
  Future<bool> updateChat(String userId, String chatId, String message) async {
    FormData formData = FormData.fromMap({
      "message": message,
      "sendBy": userId,
    });
    try {
      Response res =
          await dio.put('$socketURL/chats/msg/$chatId', data: formData);
      if (res.statusCode == 200) {
        // print(res.data);
        return true;
      }
    } catch (e) {
      // print(e);
      throw Exception(e.toString());
    }
    return false;
  }

  @override
  Future<bool> createChat(String message, String sendBy, String user1,
      String user1Name, String user2, String user2Name) async {
    FormData formData = FormData.fromMap({
      "message": message,
      "sendBy": sendBy,
      "user1": user1,
      "username1": user1Name,
      "user2": user2,
      "username2": user2Name
    });
    try {
      Response res = await dio.post('$socketURL/chats/', data: formData);
      if (res.statusCode == 200) {
        // print(res.data);
        return true;
      }
    } catch (e) {
      // print(e);
      throw Exception(e.toString());
    }
    return false;
  }

  @override
  Future<void> initSocket() async {
    socket = IO.io(
        socketURL,
        IO.OptionBuilder()
            .setTransports(['websocket']).setQuery({'userId': 1}).build());

    socket.onConnect((data) {
      // print("CONNECTED");
    });
    socket.on('server:load-chats', (data) {
      // print("Cargando chats");
    });
    socket.on('server:new-chat', (data) {
      // print("nuevo chat");
    });
    socket.on('server:new-message', (data) {
      // print("nuevo mensaje");
    });
    socket.onError((err) {
      // print(err);
    });
  }
}
