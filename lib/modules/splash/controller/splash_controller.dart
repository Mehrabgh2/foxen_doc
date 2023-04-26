import 'package:get/get.dart';

import '../../profile/fingerprint/controller/fingerprint_controller.dart';
import '../../../controller/constants_prefrences_controller.dart';
import '../../../controller/device_controller.dart';
import '../../../controller/foxen_user_controller.dart';
import '../../../controller/internet_controller.dart';
import '../../../screen/main_screen.dart';
import '../../../service/auth_service.dart';
import '../../auth/login/screen/login_screen.dart';
import '../../intro/screen/intro_screen.dart';

class SplashController extends GetxController {
  RxBool isConnectionError = false.obs;
  RxBool isFingerprintError = false.obs;
  final InternetController internetController = Get.find<InternetController>();
  final FoxenUserController foxenUserController =
      Get.find<FoxenUserController>();
  final ConstantsPrefrencesController constantsPrefrencesController =
      Get.find<ConstantsPrefrencesController>();
  final FingerprintController fingerprintController =
      Get.find<FingerprintController>();

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  void getUser() async {
    bool isDeviceConnected = await internetController.getConnectionStatus();
    if (!isDeviceConnected) {
      setIsConnectionError(true);
      return;
    }
    setIsConnectionError(false);
    var userDataEither = await AuthService.refresh();
    userDataEither.fold((user) async {
      foxenUserController.setUserUser(user);
      bool authenticate = true;
      if (constantsPrefrencesController
          .constant.value.biometricAuthentication) {
        authenticate = await fingerprintController
            .authenticate('برای ورود به برنامه هویت خود را احراز کنید');
      }
      if (authenticate) {
        if (foxenUserController.user.value!.token != null) {
          _putController(foxenUserController.user.value!.token!);
          Get.off(
              () =>
                  constantsPrefrencesController.constant.value.introductionShown
                      ? MainScreen()
                      : IntroScreen(),
              transition: Transition.cupertinoDialog);
        } else {
          Get.off(() => const LoginScreen(),
              transition: Transition.cupertinoDialog);
        }
      } else {
        setIsFingerprintError(true);
      }
    }, (error) {
      Get.off(() => const LoginScreen(),
          transition: Transition.cupertinoDialog);
    });
  }

  void setIsConnectionError(bool value) {
    isConnectionError.value = value;
    isConnectionError.refresh();
  }

  void setIsFingerprintError(bool value) {
    isFingerprintError.value = value;
    isFingerprintError.refresh();
  }

  void _putController(String token) async {
    Get.find<DeviceController>().init(token);
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
