import 'package:flutter/material.dart';
import 'package:foxenapp/widget/dialog_box.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../model/foxen_device.dart';
import '../../../../service/car_service.dart';
import '../../../../widget/overlay_toast.dart';
import 'package:get/get.dart';

class CarSettingServiceController extends GetxController {
  CarSettingServiceController({required this.device});

  final FoxenDevice device;
  RxBool isSubmitLoading = false.obs;

  late List<String> sendTypes = device.vehicle?.value.setting != null &&
          device.vehicle?.value.setting!.value.net != null &&
          device.vehicle?.value.setting!.value.net!.sendType != null
      ? device.vehicle!.value.setting!.value.net!.sendType!
      : [];

  late final TextEditingController earlyWarningController =
      TextEditingController(
    text: DeviceFieldExtractor.getCarEarlyWarning(device),
  );

  late final TextEditingController earlyWarningOdometerController =
      TextEditingController(
    text: DeviceFieldExtractor.getCarEarlyWarningOdometer(device),
  );

  late final TextEditingController earlyWarningTimeController =
      TextEditingController(
    text: DeviceFieldExtractor.getCarEarlyWarningTime(device),
  );

  late RxBool hidden = RxBool(DeviceFieldExtractor.getCarHiddenNet(device));

  late Setting tempSetting =
      device.vehicle != null && device.vehicle!.value.setting != null
          ? device.vehicle!.value.setting!.value
          : Setting();

  void submitServiceReminder() async {
    updateIsLoading(true);
    tempSetting.net?.hidden = hidden.value;
    tempSetting.net?.sendType = sendTypes;
    if (earlyWarningController.text.isNotEmpty) {
      try {
        tempSetting.net?.earlyWarning = num.parse(earlyWarningController.text);
      } catch (ex) {
        debugPrint(ex.toString());
      }
    }
    if (earlyWarningOdometerController.text.isNotEmpty) {
      try {
        tempSetting.net?.earlyWarningOdometer =
            num.parse(earlyWarningOdometerController.text);
      } catch (ex) {
        debugPrint(ex.toString());
      }
    }
    tempSetting.net?.time = earlyWarningTimeController.text;
    var response =
        await CarService.setNotificationSetting(DeviceFieldExtractor.getVehicleId(device), tempSetting);
    response.fold(
      (l) {
        tempSetting = l;
        update();
        Get.back();
        OverlayToast.showSuccessMessage('عملیات با موفقیت انجام شد');
      },
      (r) => OverlayToast.showFailureMessage(r.message.first.message),
    );
    updateIsLoading(false);
  }

  void pickEarlyWarningTime() async {
    DateTime? selectedTime =
        await DialogBox.showTimePickerDialog(context: Get.context!);
    if (selectedTime != null) {
      String hour = selectedTime.hour.toString().padLeft(2, '0');
      String minute = selectedTime.minute.toString().padLeft(2, '0');
      earlyWarningTimeController.text = '$hour:$minute';
    }
  }

  void updateIsLoading(bool value) {
    isSubmitLoading.value = value;
    isSubmitLoading.refresh();
    update();
  }

  void updateIsHidden(bool value) {
    hidden.value = value;
    hidden.refresh();
    update();
  }
}
