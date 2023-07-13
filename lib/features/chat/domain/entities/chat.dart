import 'package:eventhub_app/features/chat/domain/entities/message.dart';

class Chat {
  final String id;
  final List<Message> messages;
  final String user1;
  final String user1Name;
  final String user2;
  final String user2Name;

  Chat({
    required this.id,
    required this.messages,
    required this.user1,
    required this.user1Name,
    required this.user2,
    required this.user2Name,
  });
}
