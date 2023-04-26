class CheckLicenseResponseModel {
  final bool found;
  final bool hasOwner;

  CheckLicenseResponseModel({
    required this.found,
    required this.hasOwner,
  });

  factory CheckLicenseResponseModel.fromJson(Map<String, dynamic> json) {
    final found = json['found'];
    final hasOwner = json['hasOwner'] ?? false;
    return CheckLicenseResponseModel(found: found, hasOwner: hasOwner);
  }

  bool check() => found && !hasOwner;
}
