import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foxenapp/util/constants.dart';
import '../../../../model/request/concox_command_request.dart';
import '../../../../service/car_service.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../controller/device_controller.dart';
import '../../../../util/setting_command_factory.dart';
import '../../../../widget/overlay_toast.dart';
import '../../../../model/foxen_device.dart';
import 'package:get/get.dart';

class CarSettingEmergencyNumberController extends GetxController {
  CarSettingEmergencyNumberController({required this.device});

  final FoxenDevice device;
  late Info tempRabinInfo;
  late TextEditingController masterA;
  late TextEditingController masterB;
  late TextEditingController masterC;
  late TextEditingController masterD;
  late TextEditingController masterE;
  late TextEditingController sos1;
  late TextEditingController sos2;
  late TextEditingController sos3;
  late TextEditingController center;
  var isSubmitLoading = false.obs;
  bool isFinishedCenter = false;
  bool isFinishedSos = false;
  bool isSuccessCenter = false;
  bool isSuccessSos = false;

  @override
  void onInit() {
    tempRabinInfo = device.lastDeviceStatus != null &&
            device.lastDeviceStatus!.setting != null
        ? device.lastDeviceStatus!.setting!.value.clone()
        : Info();
    masterA = TextEditingController(
        text: device.lastDeviceStatus?.setting?.value.masterA.toString());
    masterB = TextEditingController(
        text: device.lastDeviceStatus?.setting?.value.masterB.toString());
    masterC = TextEditingController(
        text: device.lastDeviceStatus?.setting?.value.masterC.toString());
    masterD = TextEditingController(
        text: device.lastDeviceStatus?.setting?.value.masterD.toString());
    masterE = TextEditingController(
        text: device.lastDeviceStatus?.setting?.value.masterE.toString());
    sos1 = TextEditingController(
        text: DeviceFieldExtractor.getConcoxSosNumber1(device));
    sos2 = TextEditingController(
        text: DeviceFieldExtractor.getConcoxSosNumber2(device));
    sos3 = TextEditingController(
        text: DeviceFieldExtractor.getConcoxSosNumber3(device));
    center = TextEditingController(
        text: DeviceFieldExtractor.getConcoxCenterNumber(device));
    super.onInit();
  }

  void submitSimcardNumber() async {
    DeviceFieldExtractor.deviceIsRabin(device)
        ? submitRabinSimcardNumber()
        : submitConcoxSimcardNumber();
  }

  void submitConcoxSimcardNumber() async {
    updateIsSubmitLoading(true);
    resetBooleans();
    CarService.setConcoxNotificationSetting(ConcoxCommandRequest(
      deviceId: device.vehicle?.value.id,
      type: 20,
      option: ConcoxCommandRequestOption(
        phoneNumer1: sos1.text,
        phoneNumer2: sos2.text,
        phoneNumer3: sos3.text,
      ),
    )).then((value) {
      isFinishedSos = true;
      if (value.isLeft()) {
        isSuccessSos = true;
      }
      finishApiCall();
    });
    CarService.setConcoxNotificationSetting(ConcoxCommandRequest(
      deviceId: device.vehicle?.value.id,
      type: 24,
      option: ConcoxCommandRequestOption(
        phoneNumer: center.text,
      ),
    )).then((value) {
      isFinishedCenter = true;
      if (value.isLeft()) {
        isSuccessCenter = true;
      }
      finishApiCall();
    });
  }

  void finishApiCall() {
    if (isFinishedCenter && isFinishedSos) {
      if (isSuccessCenter && isSuccessSos) {
        OverlayToast.showSuccessMessage('عملیات با موفقیت انجام شد');
      } else {
        OverlayToast.showFailureMessage('عملیات با مشکل مواجه شد');
      }
      updateIsSubmitLoading(false);
    }
  }

  void resetBooleans() {
    isFinishedCenter = false;
    isFinishedSos = false;
    isSuccessCenter = false;
    isSuccessSos = false;
  }

  void submitRabinSimcardNumber() {
    updateIsSubmitLoading(true);
    final DeviceController deviceController = Get.find<DeviceController>();
    tempRabinInfo.masterA = parseNumbers(masterA.text.toString(),
        device.lastDeviceStatus?.setting?.value.masterA);
    tempRabinInfo.masterB = parseNumbers(masterB.text.toString(),
        device.lastDeviceStatus?.setting?.value.masterB);
    tempRabinInfo.masterC = parseNumbers(masterC.text.toString(),
        device.lastDeviceStatus?.setting?.value.masterC);
    tempRabinInfo.masterD = parseNumbers(masterD.text.toString(),
        device.lastDeviceStatus?.setting?.value.masterD);
    tempRabinInfo.masterE = parseNumbers(masterE.text.toString(),
        device.lastDeviceStatus?.setting?.value.masterE);
    deviceController.sendSettingCommand(
      SettingCommandFactory.createMastersCommand(
        device,
        tempRabinInfo,
      ),
    );
    startTimer(deviceController);
    OverlayToast.showSuccessMessage('درخواست ثبت شد');
  }

  void startTimer(DeviceController deviceController) {
    Timer(const Duration(milliseconds: Constants.websocketTimeout), () {
      OverlayToast.showFailureMessage('عملیات با مشکل مواجه شد');
      updateIsSubmitLoading(false);
      deviceController.updateIsWaitingForLastSetting(false);
    });
  }

  num parseNumbers(String value, num? defaultValue) {
    try {
      return num.parse(value);
    } catch (ex) {
      return defaultValue ?? 90000000000;
    }
  }

  void updateIsSubmitLoading(bool value) {
    isSubmitLoading.value = value;
    isSubmitLoading.refresh();
    update();
  }
}
