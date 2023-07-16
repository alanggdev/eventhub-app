import 'package:eventhub_app/features/chat/domain/repositories/chat_repository.dart';

class CreateChatUseCase {
  final ChatRepository chatsRepository;

  CreateChatUseCase(this.chatsRepository);

  Future<bool> execute(message, sendBy, user1, user1Name, user2, user2Name) async {
    return await chatsRepository.createChat(message, sendBy, user1, user1Name, user2, user2Name);
  }
}