import 'dart:io';

class Provider {
  int? providerId;
  int userid;
  String companyName;
  String companyDescription;
  String companyPhone;
  String companyEmail;
  String companyAddress;
  List<dynamic> daysAvailability;
  List<dynamic> hoursAvailability;
  List<dynamic> categories;
  List<dynamic> urlImages;
  List<dynamic>? eventsId;
  List<File>? filesToUpload;
  List<dynamic>? location;

  Provider({
    this.providerId,
    required this.userid,
    required this.companyName,
    required this.companyDescription,
    required this.companyPhone,
    required this.companyEmail,
    required this.companyAddress,
    required this.daysAvailability,
    required this.hoursAvailability,
    required this.categories,
    required this.urlImages,
    this.eventsId,
    this.filesToUpload,
    this.location,
  });
}
