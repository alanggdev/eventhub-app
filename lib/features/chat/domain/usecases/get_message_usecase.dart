import 'package:eventhub_app/features/chat/domain/entities/message.dart';
import 'package:eventhub_app/features/chat/domain/repositories/chat_repository.dart';

class GetMessageUseCase {
  final ChatRepository chatsRepository;

  GetMessageUseCase(this.chatsRepository);

  Future<Message?> execute(userId, chatId) async {
    return await chatsRepository.getMessage(userId, chatId);
  }
}