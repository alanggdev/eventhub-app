import 'dart:io';

class Event {
  final int? id;
  final String name;
  final String description;
  final String date;
  final List<dynamic> categories;
  final List<dynamic>? imagePaths;
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

  @override
  String toString() {
    return 'Event(id: $id, name: $name, description: $description, date: $date, '
        'categories: $categories, imagePaths: $imagePaths, userID: $userID, '
        'providersID: $providersID, filesToUpload: $filesToUpload)';
  }
}
