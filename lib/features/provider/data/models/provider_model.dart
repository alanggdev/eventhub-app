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
      urlImages: json['urlImages']
    );
  }
}
