import 'dart:async';

import 'package:foxenapp/util/constants.dart';

import '../../../../controller/device_controller.dart';
import '../../../../model/foxen_device.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../util/setting_command_factory.dart';
import '../../../../widget/overlay_toast.dart';
import 'package:get/get.dart';

class CarSettingRelayController extends GetxController {
  CarSettingRelayController({required this.device});

  final FoxenDevice device;

  late var tempRelayCutOff = DeviceFieldExtractor.getIsRelayCutOff(device).obs;
  late var tempSpareCutOff = DeviceFieldExtractor.getIsSpareCutOff(device).obs;
  late var tempConcoxRelay = DeviceFieldExtractor.getIsConcoxRelay(device).obs;
  var isSubmitLoading = false.obs;

  void submit() async {
    final DeviceController deviceController = Get.find<DeviceController>();
    updateIsSubmitLoading(true);
    deviceController.sendSettingCommand(
      SettingCommandFactory.createRelaysCommand(
        device,
        tempRelayCutOff.value,
        tempSpareCutOff.value,
        device.lastDeviceStatus != null &&
                device.lastDeviceStatus!.setting != null
            ? device.lastDeviceStatus!.setting!.value.clone()
            : Info(),
      ),
      () {
        startTimer(deviceController);
        OverlayToast.showSuccessMessage('درخواست ثبت شد');
      },
    );
  }

  void startTimer(DeviceController deviceController) {
    Timer(const Duration(milliseconds: Constants.websocketTimeout), () {
      OverlayToast.showFailureMessage('عملیات با مشکل مواجه شد');
      updateIsSubmitLoading(false);
      deviceController.updateIsWaitingForLastSetting(false);
    });
  }

  void updateIsSubmitLoading(bool value) {
    isSubmitLoading.value = value;
    isSubmitLoading.refresh();
    update();
  }

  void updateTempRelayCutOff(bool value) {
    tempRelayCutOff.value = value;
    tempRelayCutOff.refresh();
    update();
  }

  void updateTempSpareCutOff(bool value) {
    tempSpareCutOff.value = value;
    tempSpareCutOff.refresh();
    update();
  }

  void updateTempConcoxRelay(bool value) {
    tempConcoxRelay.value = value;
    tempConcoxRelay.refresh();
    update();
  }
}
