import 'dart:io';
import 'package:dio/dio.dart';

import 'package:eventhub_app/features/event/data/models/event_model.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/keys.dart';

abstract class EventDataSource {
  Future<String> createEvent(Event eventData);
  Future<List<Event>> getUserEvents(int userid);
  Future<String> deleteEvent(int eventid);
}

class EventDataSourceImpl extends EventDataSource {
  final dio = Dio();

  @override
  Future<String> createEvent(Event eventData) async {
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
        await dio.post('http://$serverURI/events/', data: formData);

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      throw Exception('Server error');
    }
  }

  @override
  Future<List<Event>> getUserEvents(int userid) async {
    Response response;
    response = await dio.get('http://$serverURI/events/list/$userid');

    if (response.statusCode == 200) {
      List<Event> userEvents = [];
      List<dynamic> data = response.data;

      if (response.data.isNotEmpty) {
        for (var eventData in data) {
          Event eventModel = EventModel.fromJson(eventData);
          userEvents.add(eventModel);
        }
        return userEvents;
      } else {
        return userEvents;
      }
    } else {
      throw Exception('Server error');
    }
  }

  @override
  Future<String> deleteEvent(int eventid) async {
    Response response;
    response = await dio.delete('http://$serverURI/events/$eventid');
    if (response.statusCode == 200) {
      return 'Deleted';
    } else {
      throw Exception('Server error');
    }
  }
}
