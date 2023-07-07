import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/data/models/provider_model.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/data/models/service_model.dart';
import 'package:eventhub_app/keys.dart';

abstract class ProviderDataSource {
  Future<List<Provider>> getCategoryProviders(String category);
  Future<List<Service>> getProviderServices(int providerid);
  Future<Provider> getProviderById(int providerid);
  Future<Provider> getProviderByUserid(int userid);
}

class ProviderDataSourceImpl extends ProviderDataSource {
  final dio = Dio();

  @override
  Future<List<Provider>> getCategoryProviders(String category) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Response response;
      response = await dio.get('$serverURL/providers/categories/$category');

      if (response.statusCode == 200) {
        List<Provider> categoryProviders = [];
        List<dynamic> data = response.data;

        for (var eventData in data) {
          Provider eventModel = ProviderModel.fromJson(eventData);
          categoryProviders.add(eventModel);
        }

        return categoryProviders;
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }
    } else {
      throw Exception('Sin conexión a internet.');
    }
  }

  @override
  Future<List<Service>> getProviderServices(int providerid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Response response;
      response = await dio.get('$serverURL/services/provider/$providerid');

      if (response.statusCode == 200) {
        List<Service> providerServices = [];
        List<dynamic> data = response.data;

        for (var serviceData in data) {
          Service service = ServiceModel.fromJson(serviceData);
          providerServices.add(service);
        }

        return providerServices;
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }
    } else {
      throw Exception('Sin conexión a internet');
    }
  }

  @override
  Future<Provider> getProviderById(int providerid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Response response = await dio.get('$serverURL/providers/$providerid');

      if (response.statusCode == 200) {
        dynamic data = response.data;
        Provider provider = ProviderModel.fromJson(data);
        return provider;
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }
    } else {
      throw Exception('Sin conexión a internet');
    }
  }

  @override
  Future<Provider> getProviderByUserid(int userid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Response response = await dio.get('$serverURL/providers/user/$userid');

      if (response.statusCode == 200) {
        dynamic data = response.data;
        Provider provider = ProviderModel.fromJson(data);
        return provider;
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }
    } else {
      throw Exception('Sin conexión a internet');
    }
  }
}
