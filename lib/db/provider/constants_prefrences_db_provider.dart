import '../../model/constants_prefrences.dart';
import '../box/hive_boxes.dart';

class ConstantsPrefrencesDBProvider {
  static final ConstantsPrefrencesDBProvider _singleton =
      ConstantsPrefrencesDBProvider._internal();

  factory ConstantsPrefrencesDBProvider() {
    return _singleton;
  }

  ConstantsPrefrencesDBProvider._internal();

  ConstantsPrefrences getConstants() {
    ConstantsPrefrences? constants;
    for (Map<dynamic, dynamic> element
        in HiveBoxes.getConstantsPrefrencesBox().values) {
      Map<String, dynamic> map = Map.fromEntries(element.entries
          .map((entry) => MapEntry(entry.key.toString(), entry.value)));
      constants = ConstantsPrefrences.fromMap(map);
    }
    return constants ??
        ConstantsPrefrences(
          showDontHaveSecurity: false,
          biometricAuthentication: false,
          introductionShown: false,
          isGoogleMap: false,
        );
  }

  Future<void> setConstants(ConstantsPrefrences constants) async {
    await removeConstants();
    await HiveBoxes.getConstantsPrefrencesBox().add(constants.toMap());
  }

  Future<void> removeConstants() async {
    await HiveBoxes.getConstantsPrefrencesBox().clear();
  }
}
