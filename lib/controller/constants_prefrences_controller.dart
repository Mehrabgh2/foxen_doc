import 'package:get/get.dart';

import '../db/provider/constants_prefrences_db_provider.dart';
import '../model/constants_prefrences.dart';

class ConstantsPrefrencesController extends GetxController {
  Rx<ConstantsPrefrences> constant = Rx(
    ConstantsPrefrences(
      showDontHaveSecurity: false,
      biometricAuthentication: false,
      introductionShown: false,
      isGoogleMap: false,
    ),
  );

  ConstantsPrefrencesDBProvider constantDBProvider =
      ConstantsPrefrencesDBProvider();
  @override
  void onInit() {
    constant.value = constantDBProvider.getConstants();
    super.onInit();
  }

  void updateConstants() {
    constant.value = constantDBProvider.getConstants();
    constant.refresh();
  }

  Future<void> updateShowDontHaveSecurity(bool value) async {
    await setConstants(constant.value..showDontHaveSecurity = value);
  }

  Future<void> updateBiometricAuthentication(bool value) async {
    await setConstants(constant.value..biometricAuthentication = value);
  }

  Future<void> updateIntroductionShown(bool value) async {
    await setConstants(constant.value..introductionShown = value);
  }

  Future<void> updateIsGoogleMap(bool value) async {
    await setConstants(constant.value..isGoogleMap = value);
  }

  Future<void> setConstants(ConstantsPrefrences constants) async {
    await constantDBProvider.setConstants(constants);
    updateConstants();
  }

  Future<void> removeConstants() async {
    await constantDBProvider.removeConstants();
    updateConstants();
  }
}
