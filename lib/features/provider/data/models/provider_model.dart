import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';

class ProviderModel extends Provider {
  ProviderModel({
    required int? providerId,
    required int userid,
    required String companyName,
    required String companyDescription,
    required String companyPhone,
    required String companyEmail,
    required String companyAddress,
    required List<dynamic> daysAvailability,
    required List<dynamic> hoursAvailability,
    required List<dynamic> categories,
    required List<dynamic> urlImages,
    List<dynamic>? eventsId,
    List<File>? filesToUpload,
    List<dynamic>? location,
  }) : super(
          providerId: providerId,
          userid: userid,
          companyName: companyName,
          companyDescription: companyDescription,
          companyPhone: companyPhone,
          companyEmail: companyEmail,
          companyAddress: companyAddress,
          daysAvailability: daysAvailability,
          hoursAvailability: hoursAvailability,
          categories: categories,
          urlImages: urlImages,
          eventsId: eventsId,
          filesToUpload: filesToUpload,
          location: location,
        );

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      providerId: json['providerId'],
      userid: json['userId'],
      companyName: json['name'],
      companyDescription: json['description'],
      companyPhone: json['phoneNumber'],
      companyEmail: json['email'],
      companyAddress: json['address'],
      daysAvailability: json['daysAvailability'],
      hoursAvailability: json['hoursAvailability'],
      categories: json['categories'],
      urlImages: json['urlImages'],
      eventsId: json['eventsId'],
      location: json['location']
    );
  }

  static FormData fromEntityToJsonWithImages(Provider data, List<MultipartFile> imageMultipartFiles) {
    String daysAvailability = data.daysAvailability.join(',');
    String hoursAvailability = '${data.hoursAvailability[0]},${data.hoursAvailability[1]}';
    String categories = data.categories.join(',');
    String urlImages = data.urlImages.join(',');
    String location = data.location!.join(',');
    final formData = FormData.fromMap({
      'name': data.companyName,
      'description': data.companyDescription,
      'phoneNumber': data.companyPhone,
      'email': data.companyEmail,
      'daysAvailability': daysAvailability,
      'hoursAvailability': hoursAvailability,
      'categories': categories,
      'images': imageMultipartFiles,
      'urlImages' : urlImages,
      'address': data.companyAddress,
      'location': location
    });
    return formData;
  }

  static FormData fromEntityToJsonWithoutImages(Provider data) {
    String daysAvailability = data.daysAvailability.join(',');
    String hoursAvailability = '${data.hoursAvailability[0]},${data.hoursAvailability[1]}';
    String categories = data.categories.join(',');
    String urlImages = data.urlImages.join(',');
    String location = data.location!.join(',');
    final formData = FormData.fromMap({
      'name': data.companyName,
      'description': data.companyDescription,
      'phoneNumber': data.companyPhone,
      'email': data.companyEmail,
      'daysAvailability': daysAvailability,
      'hoursAvailability': hoursAvailability,
      'categories': categories,
      'urlImages' : urlImages,
      'address': data.companyAddress,
      'location': location
    });
    return formData;
  }
}
