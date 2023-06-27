import 'dart:io';
import 'package:dio/dio.dart';

import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/keys.dart';

abstract class EventDataSource {
  Future<String> createEvent(Event eventData);
}

class EventDataSourceImpl extends EventDataSource {
  @override
  Future<String> createEvent(Event eventData) async {
    final dio = Dio();

    List<MultipartFile> imageMultipartFiles = [];
    for (File file in eventData.filesToUpload!) {
      MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
      imageMultipartFiles.add(multipartFile);
    }

    final formData = FormData.fromMap({
      'name': eventData.name,
      'description': eventData.description,
      'date': eventData.date,
      'categories': eventData.categories,
      'images': imageMultipartFiles,
      'userId': eventData.userID
    });

    final response =
        await dio.post('http://$eventServerURI/events/', data: formData);

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      throw Exception('Server error');
    }
  }
}
