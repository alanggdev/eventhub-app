class Notification {
  final int? id;
  final int? senderId;
  final int? receiverId;
  final String? title;
  final String? body;
  final String? providerName;
  final String? eventName;
  final String? type;
  final bool? status;
  final int? eventId;
  final int? providerId;

  Notification({
    this.id,
    this.senderId,
    this.receiverId,
    this.title,
    this.body,
    this.providerName,
    this.eventName,
    this.type,
    this.status,
    this.eventId,
    this.providerId,
  });
}
