import 'dart:io';

class Event {
  final int? id;
  final String name;
  final String description;
  final String date;
  final List<String> categories;
  final List<String>? imagePaths;
  final int userID;
  final dynamic providersID; //

  final List<File>? filesToUpload;

  Event({
    this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.categories,
    this.imagePaths,
    required this.userID,
    this.providersID,
    this.filesToUpload,
  });
}
