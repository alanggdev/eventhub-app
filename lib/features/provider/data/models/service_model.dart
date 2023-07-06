import 'dart:io';

import 'package:eventhub_app/features/provider/domain/entities/service.dart';

class ServiceModel extends Service {
  ServiceModel({
    int? serviceId,
    required String name,
    required String description,
    required List<dynamic> tags,
    List<File>? images,
    List<dynamic>? imagePaths,
    int? providerId,
  }) : super(
          serviceId: serviceId,
          name: name,
          description: description,
          tags: tags,
          images: images,
          imagePaths: imagePaths,
          providerId: providerId,
        );

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      serviceId: json['serviceId'],
      name: json['name'],
      description: json['description'],
      tags: json['tags'],
      imagePaths: json['urlImages'],
      providerId: json['providerId'],
    );
  }
}
