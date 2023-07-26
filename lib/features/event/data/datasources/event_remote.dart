import 'dart:io';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eventhub_app/features/provider/data/models/provider_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import 'package:eventhub_app/features/event/data/models/event_model.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/features/provider/domain/entities/provider.dart';

abstract class EventDataSource {
  Future<String> createEvent(Event eventData);
  Future<List<Event>> getUserEvents(int userid);
  Future<String> deleteEvent(int eventid);
  Future<List<Event>> getProviderEvents(int userid);
  Future<String> removeProvider(int eventid);
  Future<List<Provider>> getProviderAssociated(int eventid);
  Future<String> removeProviderAssociated(int eventid, int providerid);
  Future<List<Provider>> getSuggestions(String text);
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

    final response = await dio.post('$serverURL/events/', data: formData);

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      throw Exception('Server error');
    }
  }

  @override
  Future<List<Event>> getUserEvents(int userid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Response response;
      response = await dio.get('$serverURL/events/list/$userid');

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
    } else {
      throw Exception('Sin conexión a internet.');
    }
  }

  @override
  Future<String> deleteEvent(int eventid) async {
    Response response;
    response = await dio.delete('$serverURL/events/$eventid');
    if (response.statusCode == 200) {
      return 'Deleted';
    } else {
      throw Exception('Server error');
    }
  }

  @override
  Future<List<Event>> getProviderEvents(int userid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Response resUserData = await dio.get('$serverURL/providers/user/$userid');

      if (resUserData.statusCode == 200) {
        dynamic data = resUserData.data;
        int providerid = data['providerId'];

        Response response = await dio.get('$serverURL/events/provider/$providerid');

        if (response.statusCode == 200) {
          List<Event> providerEvents = [];
          List<dynamic> data = response.data;

          if (response.data.isNotEmpty) {
            for (var eventData in data) {
              Event eventModel = EventModel.fromJson(eventData);
              providerEvents.add(eventModel);
            }
            return providerEvents;
          } else {
            return providerEvents;
          }
        } else {
          throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
        }

      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }
    } else {
      throw Exception('Sin conexión a internet.');
    }
  }

  @override
  Future<String> removeProvider(int eventid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      
      Event eventToUpdate = await getEvent(eventid);
      dynamic providersId = eventToUpdate.providersID;

      await removeProviderFromEvent(providersId, eventid);
      await removeEventFromProvider(eventid);
      
      return 'Updated';

    } else {
      throw Exception('Sin conexión a internet.');
    }
  }

  Future<void> removeEventFromProvider(int eventid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? providerId = prefs.getInt('providerId');

    Response response = await dio.get('$serverURL/providers/$providerId');

    if (response.statusCode == 200) {
      List<dynamic> eventsId = response.data['eventsId'];
      eventsId.remove(eventid);

      String eventsIdtoUpdate = eventsId.join(',');
      String urlImages = response.data['urlImages'].join(',');
      String location = response.data['location'].join(',');

      final formData = FormData.fromMap({
        'eventsId': eventsIdtoUpdate,
        'urlImages': urlImages,
        'location': location
      });

      Response patchResponse = await dio.patch(
        '$serverURL/providers/$providerId',
        options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: formData,
      );

      if (patchResponse.statusCode != 200) {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }

    } else {
      throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
    }

  }

  Future<void> removeProviderFromEvent(dynamic listProvidersId, int eventid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? providerIdToRemove = prefs.getInt('providerId');

    listProvidersId.remove(providerIdToRemove);

    var body = {'providersId': listProvidersId};

    Response response = await dio.put(
      '$serverURL/events/$eventid',
      options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
      data: convert.jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
    }
  }

  @override
  Future<List<Provider>> getProviderAssociated(int eventid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      
      Event event = await getEvent(eventid);

      var body = {'ids': event.providersID};

      Response response = await dio.post(
        '$serverURL/providers/ids/',
        options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: convert.jsonEncode(body)
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Provider> providersAssociated = [];

        if (data.isNotEmpty){
          for (var json in data) {
            Provider prov = ProviderModel.fromJson(json);
            providersAssociated.add(prov);
          }
        }

        return providersAssociated;
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }

    } else {
      throw Exception('Sin conexión a internet.');
    }
  }

  Future<Event> getEvent(int eventid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      
      Response response = await dio.get('$serverURL/events/$eventid');

      if (response.statusCode == 200) {
        return EventModel.fromJson(response.data);
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }

    } else {
      throw Exception('Sin conexión a internet.');
    }
  }

  @override
  Future<String> removeProviderAssociated(int eventid, int providerid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      Event eventToUpdate = await getEvent(eventid);
      dynamic providersId = eventToUpdate.providersID;

      providersId.remove(providerid);

      var body = {'providersId': providersId};

      Response res1 = await dio.put(
        '$serverURL/events/$eventid',
        options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: convert.jsonEncode(body),
      );

      if (res1.statusCode != 200) {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }

      Response res2 = await dio.get('$serverURL/providers/$providerid');
      if (res2.statusCode == 200) {
        List<dynamic> eventsId = res2.data['eventsId'];
        eventsId.remove(eventid);

        String eventsIdtoUpdate = eventsId.join(',');
        String urlImages = res2.data['urlImages'].join(',');
        String location = res2.data['location'].join(',');

        final formData = FormData.fromMap({
          'eventsId': eventsIdtoUpdate,
          'urlImages': urlImages,
          'location': location
        });

        Response res3 = await dio.patch(
          '$serverURL/providers/$providerid',
          options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
          data: formData,
        );

        if (res3.statusCode != 200) {
          throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
        }

        return 'Updated';
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }

    } else {
      throw Exception('Sin conexión a internet.');
    }
  }

  @override
  Future<List<Provider>> getSuggestions(String text) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      var body = {"text": text};
      
      Response response = await dio.post(
        '$suggURL/suggestions/run',
        options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: convert.jsonEncode(body)
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        
        var body = {"content": data};

        Response resCategories = await dio.post(
          '$serverURL/services/content/',
          options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
          data: convert.jsonEncode(body)
        );

        if (resCategories.statusCode == 200) {

          var body = {"ids": resCategories.data};
          Response resProviders = await dio.post(
            '$serverURL/providers/ids/',
            options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
            data: convert.jsonEncode(body)
          );

          if (resProviders.statusCode == 200) {
            List<Provider> categoryProviders = [];
            List<dynamic> data = resProviders.data;

            for (var eventData in data) {
              Provider eventModel = ProviderModel.fromJson(eventData);
              categoryProviders.add(eventModel);
            }

            return categoryProviders;
          } else {
            throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
          }

        } else {
          throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
        }
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }

    } else {
      throw Exception('Sin conexión a internet.');
    }
  }
}
