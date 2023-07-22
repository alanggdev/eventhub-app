import 'dart:io';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert' as convert;

import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/features/notification/domain/entities/notification.dart';
import 'package:eventhub_app/features/notification/data/models/notification_model.dart';

abstract class NotifDataSource {
  Future<List<Notification>> getNotifications(int userid);
  Future<String> sendNotification(Notification notification, String receiverToken);
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
  Future<String> sendNotification(Notification notification, String receiverToken) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      final int notificationId = await createNotification(notification);

      if (receiverToken != 'none') {
        var body = {'fcm_token': receiverToken};

        Response response = await dio.post(
          '$serverURL/notifications/$notificationId',
          options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
          data: convert.jsonEncode(body),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          return 'Notified';
        } else {
          throw Exception('No se pudo crear la notificación. Intenlo más tarde.');
        }
      } else {
        return 'Sended';
      }

    } else {
      throw Exception('Sin conexión a internet.');
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
      throw Exception('No se pudo crear la notificación. Intenlo más tarde.');
    }

  }
}