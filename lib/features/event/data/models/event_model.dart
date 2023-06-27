import 'dart:io';

import 'package:eventhub_app/features/event/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    int? id,
    required String name,
    required String description,
    required String date,
    required List<dynamic> categories,
    List<dynamic>? imagePaths,
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

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      date: json['date'],
      categories: json['categories'],
      imagePaths: json['images'],
      userID: json['userId'],
      providersID: json['providersId'],
    );
  }
}
