import 'package:eventhub_app/features/chat/domain/repositories/chat_repository.dart';

class InitSocketUseCase {
  final ChatRepository chatsRepository;

  InitSocketUseCase(this.chatsRepository);

  Future<void> execute() async {
    await chatsRepository.initSocket();
  }
}