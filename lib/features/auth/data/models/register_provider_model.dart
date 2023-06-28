import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_provider.dart';

class RegisterProviderModel extends RegisterProvider {
  RegisterProviderModel(
      {required String companyName,
      required String companyDescription,
      required String companyPhone,
      required String companyEmail,
      required String companyAddress,
      required List<String> companySelectedDays,
      required String openTime,
      required String closeTime,
      int? userid,
      List<String>? categoriesList,
      List<File>? imagesList})
      : super(
          companyName: companyName,
          companyDescription: companyDescription,
          companyPhone: companyPhone,
          companyEmail: companyEmail,
          companyAddress: companyAddress,
          companySelectedDays: companySelectedDays,
          openTime: openTime,
          closeTime: closeTime,
          userid: userid,
          categoriesList: categoriesList,
          imagesList: imagesList,
        );

  static FormData fromEntityToJson(RegisterProvider data, List<MultipartFile> imageMultipartFiles, int userid) {
    String daysAvailability = data.companySelectedDays.join(', ');
    String hoursAvailability = '${data.openTime},${data.closeTime}';
    String categories = data.categoriesList!.join(', ');
    final formData = FormData.fromMap({
      'name': data.companyName,
      'description': data.companyDescription,
      'phoneNumber': data.companyPhone,
      'email': data.companyEmail,
      'daysAvailability': daysAvailability,
      'hoursAvailability': hoursAvailability,
      'categories': categories,
      'images': imageMultipartFiles,
      'address': data.companyAddress,
      'userId': userid,
      'servicesId': []
    });
    return formData;
  }
}
