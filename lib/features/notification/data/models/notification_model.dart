import 'package:eventhub_app/features/notification/domain/entities/notification.dart';

class NotificationModel extends Notification {
  NotificationModel({
    int? id,
    int? senderId,
    int? receiverId,
    String? title,
    String? body,
    String? providerName,
    String? eventName,
    String? type,
    String? status,
  }) : super(
          id: id,
          senderId: senderId,
          receiverId: receiverId,
          title: title,
          body: body,
          providerName: providerName,
          eventName: eventName,
          type: type,
          status: status,
        );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['notificationId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      title: json['title'],
      body: json['body'],
      providerName: json['providerName'],
      eventName: json['eventName'],
      type: json['type'],
      status: json['status'],
    );
  }
}
