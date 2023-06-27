import 'dart:io';

import 'package:eventhub_app/features/event/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    int? id,
    required String name,
    required String description,
    required String date,
    required List<String> categories,
    List<String>? imagePaths,
    required int userID,
    dynamic providersID,
    List<File>? filesToUpload,
  }) : super(
          id: id,
          name: name,
          description: description,
          date: date,
          categories: categories,
          imagePaths: imagePaths,
          userID: userID,
          providersID: providersID,
          filesToUpload: filesToUpload,
        );

  static Map<String, dynamic> fromEntityToJsonCreate(Event data) {
    return {
      'name': data.name,
      'description': data.description,
      'date': data.date,
      'categories': data.categories,
      'images': data.filesToUpload,
      'userid': data.userID,
      'providersId': data.providersID,
    };
  }
}
