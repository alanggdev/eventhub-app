import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/features/notification/domain/entities/notification.dart';
import 'package:eventhub_app/features/notification/data/models/notification_model.dart';

abstract class NotifDataSource {
  Future<List<Notification>> getNotifications(int userid);
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
}