import 'dart:io';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert' as convert;

import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/features/notification/domain/entities/notification.dart';
import 'package:eventhub_app/features/notification/data/models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NotifDataSource {
  Future<List<Notification>> getNotifications(int userid);
  Future<String> sendNotification(Notification notification);
  Future<String> responseNotification(Notification notification, String typeRes);
}

class NotifDataSourceImpl extends NotifDataSource {
  final dio = Dio();

  @override
  Future<List<Notification>> getNotifications(int userid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      Response response = await dio.get('$serverURL/notifications/user/$userid');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Notification> userNotifications = [];

        if (data.isNotEmpty) {
          for (var key in data) {
            Notification notification = NotificationModel.fromJson(key);
            userNotifications.add(notification);
          }
        }

        return userNotifications;

      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }

    } else {
      throw Exception('Sin conexión a internet.');
    }
  }

  @override
  Future<String> sendNotification(Notification notification) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      final int notificationId = await createNotification(notification);
      final String receiverToken = await getUserReceiver(notification.receiverId!);

      if (receiverToken != 'none') {
        var body = {'fcm_token': receiverToken};

        Response response = await dio.post(
          '$serverURL/notifications/$notificationId',
          options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
          data: convert.jsonEncode(body),
        );

        if (response.statusCode == 202) {
          return 'Notified';
        } else {
          throw Exception('No se pudo crear la notificación. Intenlo más tarde. (SN)');
        }
      } else {
        return 'Notif Sent';
      }

    } else {
      throw Exception('Sin conexión a internet.');
    }
  }

  Future<String> getUserReceiver(int userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('access_token');

    Response response = await dio.get(
      '$serverURL/auth/user/$userid',
      options: Options(headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"}),
    );

    if (response.statusCode == 200) {
      return response.data['pay_load']['firebase_token'];
    } else {
      return 'none';
    }
  }

  Future<int> createNotification(Notification notification) async {
    var body = NotificationModel.fromEntityToJson(notification);

    Response response = await dio.post(
      '$serverURL/notifications/',
      options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
      data: convert.jsonEncode(body),
    );

    if (response.statusCode == 201) {
      return response.data['notificationId'];
    } else {
      throw Exception('No se pudo crear la notificación. Intenlo más tarde. (CN)');
    }

  }

  @override
  Future<String> responseNotification(Notification notification, String typeRes) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      if (typeRes == 'Accept') {

        await updateProvider(notification.providerId!, notification.eventId!);
        await updateEvent(notification.eventId!, notification.providerId!);

        var body = {'status': true};
        Response response = await dio.patch(
          '$serverURL/notifications/${notification.id}',
          options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
          data: convert.jsonEncode(body),
        );

        if (response.statusCode == 200) {
          Notification notif = Notification(
            senderId: notification.receiverId,
            receiverId: notification.senderId,
            title: 'Colaboración aceptada',
            body: '${notification.providerName} ha aceptado la colaboración a ${notification.eventName}',
            providerName: notification.providerName,
            eventName: notification.eventName,
            type: 'Response',
            eventId: notification.eventId,
            providerId: notification.providerId,
          );
          await sendNotification(notif);
          return 'Updated';
        } else {
          throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
        }

      } else {

        var body = {'status': false};
        Response response = await dio.patch(
          '$serverURL/notifications/${notification.id}',
          options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
          data: convert.jsonEncode(body),
        );

        if (response.statusCode == 200) {
          Notification notif = Notification(
            senderId: notification.receiverId,
            receiverId: notification.senderId,
            title: 'Colaboración rechazada',
            body: '${notification.providerName} ha rechazado la colaboración a ${notification.eventName}',
            providerName: notification.providerName,
            eventName: notification.eventName,
            type: 'Response',
            eventId: notification.eventId,
            providerId: notification.providerId,
          );
          await sendNotification(notif);
          return 'Updated';
        } else {
          throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
        }

      }

    } else {
      throw Exception('Sin conexión a internet.');
    }
  }

  Future<String> updateProvider(int providerId, int eventId) async {
    Response getResponse = await dio.get(
      '$serverURL/providers/$providerId'
    );

    if (getResponse.statusCode == 200) {
      List<dynamic> eventsId = getResponse.data['eventsId'];
      if (!eventsId.contains(eventId)) {
        eventsId.add(eventId);
      }

      String eventsIdtoUpdate = eventsId.join(',');
      String urlImages = getResponse.data['urlImages'].join(',');
      String location = getResponse.data['location'].join(',');
      
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

      if (patchResponse.statusCode == 200) {
        return 'Provider updated with new event id';
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }
    } else {
      throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
    }
  }

  Future<String> updateEvent(int eventId, int providerId) async {
    Response getResponse = await dio.get(
      '$serverURL/events/$eventId'
    );

    if (getResponse.statusCode == 200) {
      List<dynamic> providersId = getResponse.data['providersId'];
      if (!providersId.contains(providerId)) {
        providersId.add(providerId);
      }
      
      var body = {'providersId': providersId};

      Response patchResponse = await dio.put(
        '$serverURL/events/$eventId',
        options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: convert.jsonEncode(body),
      );

      if (patchResponse.statusCode == 200) {
        return 'Event updated with new provider id';
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }
    } else {
      throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
    }
  }
}