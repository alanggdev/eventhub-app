import 'package:eventhub_app/features/chat/data/datasources/chat_remote.dart';
import 'package:eventhub_app/features/chat/domain/entities/chat.dart';
import 'package:eventhub_app/features/chat/domain/entities/message.dart';
import 'package:eventhub_app/features/chat/domain/repositories/chat_repository.dart';

class ChatsRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatsRepositoryImpl({required this.chatRemoteDataSource});

  @override
  Future<List<Chat>?> getChatList(String userId) async {
    return await chatRemoteDataSource.getChatList(userId);
  }

  @override
  Future<Chat?> getChat(String id) async {
    return await chatRemoteDataSource.getChat(id);
  }

  @override
  Future<Message?> getMessage(String userId, String chatId) async {
    return await chatRemoteDataSource.getMessage(userId, chatId);
  }

  @override
  Future<bool> updateChat(String userId, String chatId, String message) async {
    return await chatRemoteDataSource.updateChat(userId, chatId, message);
  }

  @override
  Future<bool> createChat(String message, String sendBy, String user1, String user1Name, String user2, String user2Name) async {
    return await chatRemoteDataSource.createChat(message, sendBy, user1, user1Name, user2, user2Name);
  }

  @override
  Future<void> initSocket() async {
    await chatRemoteDataSource.initSocket();
  }
}