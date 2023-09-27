class WardInformation {
  final int wardNumber;
  final String alderpersonName;
  final String wardEmail;
  final String wardPhone;
  final String? wardFax;
  final String? wardAddress;
  final Map<String, String?> wardWebsites;
  final String? alderpersonImagePath;

  WardInformation({
    required this.wardNumber,
    required this.alderpersonName,
    required this.wardEmail,
    required this.wardPhone,
    this.wardFax,
    this.wardAddress,
    Map<String, String?>? wardWebsites,
    this.alderpersonImagePath,
  }) : wardWebsites = wardWebsites ?? {
          "Website": null,
          "Facebook": null,
          "Twitter": null,
          "Instagram": null,
          "YouTube": null,
          "LinkedIn": null,
        };
}
