import 'dart:io';

class Service {
  final String name;
  final String description;
  final List<dynamic> tags;
  final List<File>? images;
  final int? providerId;

  Service(
      {required this.name,
      required this.description,
      required this.tags,
      this.images,
      this.providerId});
}
