import 'dart:io';

class Service {
  final int? serviceId;
  String name;
  String description;
  List<dynamic> tags;
  List<File>? images;
  List<dynamic>? imagePaths;
  int? providerId;

  Service({
    this.serviceId,
    required this.name,
    required this.description,
    required this.tags,
    this.images,
    this.imagePaths,
    this.providerId,
  });
}
