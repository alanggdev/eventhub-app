import 'package:eventhub_app/features/chat/domain/entities/message.dart';

class Chat {
  final String? id;
  List<Message>? messages;
  final String? user1;
  final String? user1Name;
  final String? user2;
  final String? user2Name;

  Chat({
    this.id,
    this.messages,
    this.user1,
    this.user1Name,
    this.user2,
    this.user2Name,
  });
}
