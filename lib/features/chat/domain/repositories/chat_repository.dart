import 'package:eventhub_app/features/chat/domain/entities/chat.dart';
import 'package:eventhub_app/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<List<Chat>?> getChatList(String userId);
  Future<Chat?> getChat(String id);
  Future<Message?> getMessage(String userId, String chatId);
  Future<bool> updateChat(String userId, String chatId, String message);
  Future<bool> createChat(String message, String sendBy, String user1, String user1Name, String user2, String user2Name);
  Future<void> initSocket();
}