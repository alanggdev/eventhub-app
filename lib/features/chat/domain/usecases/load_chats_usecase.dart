import 'package:eventhub_app/features/chat/domain/entities/chat.dart';
import 'package:eventhub_app/features/chat/domain/repositories/chat_repository.dart';

class LoadChatsUseCase {
  final ChatRepository chatsRepository;

  LoadChatsUseCase(this.chatsRepository);

  Future<List<Chat>?> execute(userId) async {
    return await chatsRepository.getChatList(userId);
  }
}