import 'package:foxenapp/widget/overlay_toast.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../controller/constants_prefrences_controller.dart';

class FingerprintController extends GetxController {
  final LocalAuthentication biometric = LocalAuthentication();
  final ConstantsPrefrencesController constantsPrefrencesController =
      Get.find<ConstantsPrefrencesController>();

  Future<void> turnOn() async {
    if (await canAuthenticate()) {
      bool auth = await authenticate('برای روشن کردن هویت خود را احراز کنید');
      if (auth) {
        constantsPrefrencesController.updateBiometricAuthentication(true);
      }
    } else {
      OverlayToast.showFailureMessage('دستگاه قابلیت احراز را ندارد');
    }
  }

  Future<void> turnOff() async {
    if (await canAuthenticate()) {
      bool auth = await authenticate('برای خاموش کردن هویت خود را احراز کنید');
      if (auth) {
        constantsPrefrencesController.updateBiometricAuthentication(false);
      }
    } else {
      OverlayToast.showFailureMessage('دستگاه قابلیت احراز را ندارد');
    }
  }

  Future<bool> authenticate(String title) async {
    try {
      return await biometric.authenticate(
          localizedReason: title,
          options: const AuthenticationOptions(biometricOnly: true));
    } catch (ex) {
      return false;
    }
  }

  Future<bool> canAuthenticate() async {
    final bool canAuthenticateWithBiometrics =
        await biometric.canCheckBiometrics;
    return canAuthenticateWithBiometrics || await biometric.isDeviceSupported();
  }
}
