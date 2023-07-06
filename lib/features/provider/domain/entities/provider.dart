class Provider {
  final int? providerId;
  final int userid;
  final String companyName;
  final String companyDescription;
  final String companyPhone;
  final String companyEmail;
  final String companyAddress;
  final List<dynamic> daysAvailability;
  final List<dynamic> hoursAvailability;
  final List<dynamic> categories;
  final List<dynamic> urlImages;

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
  });
}
