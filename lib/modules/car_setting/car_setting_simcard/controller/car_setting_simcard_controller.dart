import 'package:flutter/material.dart';
import 'package:foxenapp/util/device_field_extractor.dart';
import '../../../../model/foxen_device.dart';
import '../../../../service/car_service.dart';
import '../../../../widget/overlay_toast.dart';
import 'package:get/get.dart';

class CarSettingSimcardController extends GetxController {
  CarSettingSimcardController({required this.device});

  final FoxenDevice device;
  late final TextEditingController simCardController = TextEditingController(
      text: DeviceFieldExtractor.getCarSimNumber(device) ?? '');
  var isSubmitLoading = false.obs;

  void submitSimcardNumber() async {
    if (simCardController.text.isEmpty) {
      OverlayToast.showFailureMessage('شماره دستگاه را وارد کنید');
    } else {
      updateIsSubmitLoading(true);
      var response = await CarService.setDeviceSimNumber(
          device.device != null ? device.device?.id ?? 0 : 0,
          simCardController.text);
      updateIsSubmitLoading(false);
      response.fold(
        (l) {
          device.device?.simno = Rx(l ?? simCardController.text);
          device.device?.simno!.refresh();
          Get.back();
        },
        (r) => OverlayToast.showFailureMessage(r.message.first.message),
      );
    }
  }

  void updateIsSubmitLoading(bool value) {
    isSubmitLoading.value = value;
    isSubmitLoading.refresh();
    update();
  }
}
