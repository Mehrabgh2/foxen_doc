import 'package:hive/hive.dart';
part 'constants_prefrences.g.dart';

@HiveType(typeId: 3)
class ConstantsPrefrences {
  ConstantsPrefrences({
    required this.showDontHaveSecurity,
    required this.biometricAuthentication,
    required this.introductionShown,
    required this.isGoogleMap,
  });

  @HiveField(0)
  bool showDontHaveSecurity;
  @HiveField(1)
  bool biometricAuthentication;
  @HiveField(2)
  bool introductionShown;
  @HiveField(3)
  bool isGoogleMap;

  factory ConstantsPrefrences.fromMap(Map<String, dynamic> json) {
    final showDontHaveSecurity = json['show_dont_have_security'] ?? false;
    final biometricAuthentication = json['biometric_authentication'] ?? false;
    final introductionShown = json['introduction_shown'] ?? false;
    final isGoogleMap = json['is_google_map'] ?? false;
    return ConstantsPrefrences(
      showDontHaveSecurity: showDontHaveSecurity,
      biometricAuthentication: biometricAuthentication,
      introductionShown: introductionShown,
      isGoogleMap: isGoogleMap,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['show_dont_have_security'] = showDontHaveSecurity;
    data['biometric_authentication'] = biometricAuthentication;
    data['introduction_shown'] = introductionShown;
    data['is_google_map'] = isGoogleMap;
    return data;
  }
}
