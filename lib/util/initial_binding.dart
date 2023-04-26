import 'package:foxenapp/controller/device_controller.dart';
import 'package:foxenapp/modules/map/controller/custom_map_controller.dart';

import '../modules/profile/fingerprint/controller/fingerprint_controller.dart';
import '../controller/constants_prefrences_controller.dart';
import '../controller/foxen_user_controller.dart';
import '../controller/internet_controller.dart';
import '../modules/intro/controller/intro_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InternetController());
    Get.put(FoxenUserController());
    Get.put(ConstantsPrefrencesController());
    Get.put(FingerprintController());
    Get.put(IntroController());
    Get.put(DeviceController());
    Get.put(CustomMapController());
  }
}
