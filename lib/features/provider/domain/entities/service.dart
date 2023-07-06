import 'dart:io';

class Service {
  final int? serviceId;
  final String name;
  final String description;
  final List<dynamic> tags;
  final List<File>? images;
  final List<dynamic>? imagePaths;
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
