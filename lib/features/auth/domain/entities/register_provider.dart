import 'dart:io';

class RegisterProvider {
  final String companyName;
  final String companyDescription;
  final String companyPhone;
  final String companyEmail;
  final String companyAddress;
  final List<String> companySelectedDays;
  final String openTime;
  final String closeTime;
  final int? userid;
  List<String>? categoriesList;
  List<File>? imagesList;

  RegisterProvider({
    required this.companyName,
    required this.companyDescription,
    required this.companyPhone,
    required this.companyEmail,
    required this.companyAddress,
    required this.companySelectedDays,
    required this.openTime,
    required this.closeTime,
    this.userid,
    this.categoriesList,
    this.imagesList,
  });

  @override
  String toString() {
    return 'RegisterProvider{'
        'companyName: $companyName, '
        'companyDescription: $companyDescription, '
        'companyPhone: $companyPhone, '
        'companyEmail: $companyEmail, '
        'companyAddress: $companyAddress, '
        'companySelectedDays: $companySelectedDays, '
        'openTime: $openTime, '
        'closeTime: $closeTime, '
        'categoriesList: $categoriesList, '
        'imagesList: $imagesList'
        '}';
  }
}
