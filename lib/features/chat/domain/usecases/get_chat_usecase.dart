import 'package:eventhub_app/features/chat/domain/entities/chat.dart';
import 'package:eventhub_app/features/chat/domain/repositories/chat_repository.dart';

class GetChatUseCase {
  final ChatRepository chatsRepository;

  GetChatUseCase(this.chatsRepository);

  Future<Chat?> execute(id) async {
    return await chatsRepository.getChat(id);
  }
}