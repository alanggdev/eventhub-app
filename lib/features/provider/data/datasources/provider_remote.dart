import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/data/models/provider_model.dart';
import 'package:eventhub_app/features/provider/data/models/service_model.dart';


abstract class ProviderDataSource {
  Future<List<Provider>> getCategoryProviders(String category);
  Future<List<Service>> getProviderServices(int providerid);
  Future<Provider> getProviderById(int providerid);
  Future<Provider> getProviderByUserid(int userid);
  Future<String> updateProviderData(Provider providerData);
  Future<String> createService(Service service, int providerid);
  Future<String> deleteService(int serviceid);
  Future<String> updateService(Service service);
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

  @override
  Future<String> updateProviderData(Provider providerData) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      
      final FormData formData;
      if (providerData.filesToUpload!.isNotEmpty) {
        List<MultipartFile> imageMultipartFiles = [];
        for (File file in providerData.filesToUpload!) {
          MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
          imageMultipartFiles.add(multipartFile);
        }
        formData = ProviderModel.fromEntityToJsonWithImages(providerData, imageMultipartFiles);
      } else {
        formData = ProviderModel.fromEntityToJsonWithoutImages(providerData);
      }

      Response response = await dio.patch('$serverURL/providers/${providerData.providerId}', data: formData);

      if (response.statusCode == 200) {
        return "Provider updated";
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }
    } else {
      throw Exception('Sin conexión a internet');
    }
  }

  @override
  Future<String> createService(Service service, int providerid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      List<MultipartFile> imageMultipartFiles = [];

      for (File file in service.images!) {
        MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
        imageMultipartFiles.add(multipartFile);
      }

      var body = [{
        "providerId": providerid,
        "name": service.name,
        "description": service.description,
        "tags": service.tags,
        "amountImages": service.images?.length
      }];

      final formData = FormData.fromMap({
        'services': body,
        'images' : imageMultipartFiles
      });

      Response response = await dio.post('$serverURL/services/', data: formData);

      if (response.statusCode == 201) {
        return 'Services created';
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }

    } else {
      throw Exception('Sin conexión a internet');
    }
  }

  @override
  Future<String> deleteService(int serviceid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Response response = await dio.delete('$serverURL/services/$serviceid');

      if (response.statusCode == 200) {
        return 'Service deleted';
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }
    } else {
      throw Exception('Sin conexión a internet');
    }
  }

  @override
  Future<String> updateService(Service service) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      List<MultipartFile> imageMultipartFiles = [];
      if (service.images!.isNotEmpty) {
        for (File file in service.images!) {
          MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
          imageMultipartFiles.add(multipartFile);
        }
      }

      FormData formData = ServiceModel.fromEntityToJson(service, imageMultipartFiles);

      Response response = await dio.patch('$serverURL/services/${service.serviceId}', data: formData);

      if (response.statusCode == 200) {
        return 'Service updated';
      } else {
        throw Exception('Ha ocurrido un error en nuestros servicios. Intentelo más tarde.');
      }

    } else {
      throw Exception('Sin conexión a internet');
    }
  }
}
