import '../../../../model/request/app_setting_request.dart';
import '../../../../service/car_service.dart';
import '../../../../widget/overlay_toast.dart';
import 'package:get/get.dart';

class CarSettingCustomShowController extends GetxController {
  RxBool movementMapLoading = false.obs;
  RxBool movementCarLoading = false.obs;
  RxBool accMapLoading = false.obs;
  RxBool accCarLoading = false.obs;

  void updateAppSetting(
      RxBool loading, num vehicleId, AppSettingRequest settingRequest) async {
    updateIsLoading(loading, true);
    var response = await CarService.setAppSetting(vehicleId, settingRequest);
    updateIsLoading(loading, false);
    response.fold(
      (l) {},
      (r) => OverlayToast.showFailureMessage(r.message.first.message),
    );
  }

  void updateIsLoading(RxBool old, bool value) {
    old.value = value;
    old.refresh();
    update();
  }
}
