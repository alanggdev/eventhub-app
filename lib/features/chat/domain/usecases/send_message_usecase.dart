import 'package:eventhub_app/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository chatsRepository;

  SendMessageUseCase(this.chatsRepository);

  Future<bool> execute(userId, chatId, message) async {
    return await chatsRepository.updateChat(userId, chatId, message);
  }
}