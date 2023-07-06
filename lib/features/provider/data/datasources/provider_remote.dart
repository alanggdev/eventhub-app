import 'package:dio/dio.dart';

import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/data/models/provider_model.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/data/models/service_model.dart';
import 'package:eventhub_app/keys.dart';

abstract class ProviderDataSource {
  Future<List<Provider>> getCategoryProviders(String category);
  Future<List<Service>> getProviderServices(int providerid);
}

class ProviderDataSourceImpl extends ProviderDataSource {
  final dio = Dio();

  @override
  Future<List<Provider>> getCategoryProviders(String category) async {
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
      throw Exception('Server error');
    }
  }

  @override
  Future<List<Service>> getProviderServices(int providerid) async {
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
      throw Exception('Server error');
    }
  }
}
