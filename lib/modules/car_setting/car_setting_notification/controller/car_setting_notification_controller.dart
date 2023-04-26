import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foxenapp/util/constants.dart';
import '../../../../controller/device_controller.dart';
import '../../../../enum/car_setting_concox_alarm_type.dart';
import '../../../../enum/car_setting_concox_notification_type.dart';
import '../../../../model/request/concox_command_request.dart';
import '../../../../util/setting_command_factory.dart';
import '../../../../enum/car_setting_app_notification_type.dart';
import '../../../../enum/car_setting_rabin_notification_type.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../model/foxen_device.dart';
import '../../../../service/car_service.dart';
import '../../../../widget/overlay_toast.dart';
import 'package:get/get.dart';

class CarSettingNotificationController extends GetxController {
  CarSettingNotificationController({required this.device});

  final FoxenDevice device;
  late final TextEditingController maxSpeedController = TextEditingController();
  late final TextEditingController simChargeController =
      TextEditingController();
  late final TextEditingController lastConnectionController =
      TextEditingController();
  late final TextEditingController lastLocationController =
      TextEditingController();
  late final TextEditingController speedThresholdController =
      TextEditingController();
  late final TextEditingController simcardMncController =
      TextEditingController();
  late final TextEditingController concoxMaxSpeedController =
      TextEditingController();
  late final TextEditingController concoxMaxSpeedTimeController =
      TextEditingController();
  late final TextEditingController concoxMovementRadiusController =
      TextEditingController();

  late Setting tempSetting;
  late ConcoxAlarm tempConcoxAlarm;
  late Info tempRabinInfo;

  RxBool isSubmitLoading = false.obs;
  RxBool isDeviceSubmitLoading = false.obs;

  bool isFinishedVibration = false;
  bool isSuccessVibration = false;
  bool isFinishedAcc = false;
  bool isSuccessAcc = false;
  bool isFinishedBattery = false;
  bool isSuccessBattery = false;
  bool isFinishedSos = false;
  bool isSuccessSos = false;
  bool isFinishedMoving = false;
  bool isSuccessMoving = false;
  bool isFinishedSpeed = false;
  bool isSuccessSpeed = false;

  @override
  void onInit() {
    getAndSetValue();
    super.onInit();
  }

  void getAndSetValue() {
    maxSpeedController.text = DeviceFieldExtractor.getCarMaxSpeed(device);
    simChargeController.text = DeviceFieldExtractor.getVehicleSimCharge(device);
    lastConnectionController.text =
        DeviceFieldExtractor.getCarLastConnectionAlarm(device);
    lastLocationController.text =
        DeviceFieldExtractor.getCarLastLocationAlarm(device);
    speedThresholdController.text =
        DeviceFieldExtractor.getCarSpeedThreshold(device);
    simcardMncController.text = DeviceFieldExtractor.getCarSimcardMNC(device);
    concoxMaxSpeedController.text =
        DeviceFieldExtractor.getConcoxMaxSpeed(device);
    concoxMaxSpeedTimeController.text =
        DeviceFieldExtractor.getConcoxMaxSpeedTime(device);
    concoxMovementRadiusController.text =
        DeviceFieldExtractor.getConcoxMovementRadius(device);
    tempSetting =
        device.vehicle != null && device.vehicle!.value.setting != null
            ? device.vehicle!.value.setting!.value
            : Setting();
    tempConcoxAlarm = device.device != null &&
            device.device!.info != null &&
            device.device!.info!.value.concoxAlarm != null
        ? device.device!.info!.value.concoxAlarm!
        : ConcoxAlarm();
    tempRabinInfo = device.lastDeviceStatus != null &&
            device.lastDeviceStatus!.setting != null
        ? device.lastDeviceStatus!.setting!.value.clone()
        : Info();
    tempRabinInfo.smsCallMode ??= SmsCallMode.fromHex(0);
    update();
  }

  void submitReminders() async {
    updateIsSubmitLoading(true);
    try {
      tempSetting.overSpeed?.max = num.parse(maxSpeedController.text);
      tempSetting.simCharge?.value = num.parse(simChargeController.text);
      tempSetting.lastPacket?.time =
          (num.parse(lastConnectionController.text) * 3600).toString();
      tempSetting.lastTrack?.time =
          (num.parse(lastLocationController.text) * 3600).toString();
      var response = await CarService.setNotificationSetting(
          DeviceFieldExtractor.getVehicleId(device), tempSetting);
      response.fold(
        (l) {
          tempSetting = l;
          update();
          Get.back();
          OverlayToast.showSuccessMessage('عملیات با موفقیت انجام شد');
        },
        (r) => OverlayToast.showFailureMessage(r.message.first.message),
      );
    } catch (ex) {
      OverlayToast.showFailureMessage('مقادیر ورودی صحیح نیست');
      updateIsSubmitLoading(false);
    }
    updateIsSubmitLoading(false);
  }

  void submitDeviceReminders() {
    DeviceFieldExtractor.deviceIsRabin(device)
        ? submitRabinReminders()
        : submitConcoxReminders();
  }

  void submitRabinReminders() {
    final DeviceController deviceController = Get.find<DeviceController>();
    updateIsDeviceSubmitLoading(true);
    try {
      tempRabinInfo.speedThreshold = num.parse(speedThresholdController.text);
    } catch (ex) {}
    try {
      tempRabinInfo.simCardMNC = num.parse(simcardMncController.text);
    } catch (ex) {}
    deviceController.sendSettingCommand(
      SettingCommandFactory.createRabinNotificationCommand(
        device,
        tempRabinInfo,
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

  void submitConcoxReminders() async {
    updateIsDeviceSubmitLoading(true);
    resetBooleans();
    if (tempConcoxAlarm.vibrationAlarm != null) {
      CarService.setConcoxNotificationSetting(ConcoxCommandRequest(
        deviceId: device.device?.id,
        type: 39,
        option: ConcoxCommandRequestOption(
          a: tempConcoxAlarm.vibrationAlarm?.state ?? false ? 'ON' : 'OFF',
          m: tempConcoxAlarm.vibrationAlarm?.alarmType?.index,
        ),
      )).then((value) {
        isFinishedVibration = true;
        if (value.isLeft()) {
          isSuccessVibration = true;
        }
        finishApiCall();
      });
    } else {
      isFinishedVibration = true;
      isSuccessVibration = true;
    }
    if (tempConcoxAlarm.accAlarm != null) {
      CarService.setConcoxNotificationSetting(ConcoxCommandRequest(
        deviceId: device.device?.id,
        type: 42,
        option: ConcoxCommandRequestOption(
          a: tempConcoxAlarm.accAlarm?.state ?? false ? 'ON' : 'OFF',
        ),
      )).then((value) {
        isFinishedAcc = true;
        if (value.isLeft()) {
          isSuccessAcc = true;
        }
        finishApiCall();
      });
    } else {
      isFinishedAcc = true;
      isSuccessAcc = true;
    }

    if (tempConcoxAlarm.batteryAlarm != null) {
      CarService.setConcoxNotificationSetting(ConcoxCommandRequest(
        deviceId: device.device?.id,
        type: 45,
        option: ConcoxCommandRequestOption(
          a: tempConcoxAlarm.batteryAlarm?.state ?? false ? 'ON' : 'OFF',
        ),
      )).then((value) {
        isFinishedBattery = true;
        if (value.isLeft()) {
          isSuccessBattery = true;
        }
        finishApiCall();
      });
    } else {
      isFinishedBattery = true;
      isSuccessBattery = true;
    }

    if (tempConcoxAlarm.sosAlarm != null) {
      CarService.setConcoxNotificationSetting(ConcoxCommandRequest(
        deviceId: device.device?.id,
        type: 48,
        option: ConcoxCommandRequestOption(
          a: tempConcoxAlarm.sosAlarm?.state ?? false ? 'ON' : 'OFF',
        ),
      )).then((value) {
        isFinishedSos = true;
        if (value.isLeft()) {
          isSuccessSos = true;
        }
        finishApiCall();
      });
    } else {
      isFinishedSos = true;
      isSuccessSos = true;
    }

    if (tempConcoxAlarm.movingAlarm != null) {
      try {
        CarService.setConcoxNotificationSetting(ConcoxCommandRequest(
          deviceId: device.device?.id,
          type: 53,
          option: ConcoxCommandRequestOption(
            a: tempConcoxAlarm.movingAlarm?.state ?? false ? 'ON' : 'OFF',
            m: tempConcoxAlarm.movingAlarm?.alarmType?.index,
            r: int.parse(concoxMovementRadiusController.text),
          ),
        )).then((value) {
          isFinishedMoving = true;
          if (value.isLeft()) {
            isSuccessMoving = true;
          }
          finishApiCall();
        });
      } catch (ex) {
        // TODO handle
        debugPrint(ex.toString());
      }
    } else {
      isFinishedMoving = true;
      isSuccessMoving = true;
    }

    if (tempConcoxAlarm.speedAlarm != null) {
      try {
        CarService.setConcoxNotificationSetting(ConcoxCommandRequest(
          deviceId: device.device?.id,
          type: 56,
          option: ConcoxCommandRequestOption(
            a: tempConcoxAlarm.speedAlarm?.state ?? false ? 'ON' : 'OFF',
            b: int.parse(concoxMaxSpeedTimeController.text),
            c: int.parse(concoxMaxSpeedController.text),
          ),
        )).then((value) {
          isFinishedSpeed = true;
          if (value.isLeft()) {
            isSuccessSpeed = true;
          }
          finishApiCall();
        });
      } catch (ex) {
        // TODO handle
        debugPrint(ex.toString());
      }
    } else {
      isFinishedSpeed = true;
      isSuccessSpeed = true;
    }
  }

  void finishApiCall() {
    if (isFinishedVibration &&
        isFinishedAcc &&
        isFinishedBattery &&
        isFinishedSos &&
        isFinishedMoving &&
        isFinishedSpeed) {
      if (isSuccessVibration &&
          isSuccessAcc &&
          isSuccessBattery &&
          isSuccessSos &&
          isSuccessMoving &&
          isSuccessSpeed) {
        OverlayToast.showSuccessMessage('عملیات با موفقیت انجام شد');
      } else {
        OverlayToast.showFailureMessage('عملیات با مشکل مواجه شد');
      }
      updateIsDeviceSubmitLoading(false);
    }
  }

  void resetBooleans() {
    isFinishedVibration = false;
    isSuccessVibration = false;
    isFinishedAcc = false;
    isSuccessAcc = false;
    isFinishedBattery = false;
    isSuccessBattery = false;
    isFinishedSos = false;
    isSuccessSos = false;
    isFinishedMoving = false;
    isSuccessMoving = false;
    isFinishedSpeed = false;
    isSuccessSpeed = false;
  }

  void updateIsSubmitLoading(bool value) {
    isSubmitLoading.value = value;
    isSubmitLoading.refresh();
    update();
  }

  void updateIsDeviceSubmitLoading(bool value) {
    isDeviceSubmitLoading.value = value;
    isDeviceSubmitLoading.refresh();
    update();
  }

  void updateRabinSetting(
    CarSettingRabinNotificationType type,
    bool isCall,
    bool isOn,
  ) {
    switch (type) {
      case CarSettingRabinNotificationType.speedAlarm:
        if (isCall) {
          tempRabinInfo.smsCallMode!.speedCallAlarm = isOn;
        } else {
          tempRabinInfo.smsCallMode!.speedSmsAlarm = isOn;
        }
        break;
      case CarSettingRabinNotificationType.sosAlarm:
        if (isCall) {
          tempRabinInfo.smsCallMode!.sosCallAlarm = isOn;
        } else {
          tempRabinInfo.smsCallMode!.sosSmsAlarm = isOn;
        }
        break;
      case CarSettingRabinNotificationType.securityChangeAlarm:
        if (isCall) {
          tempRabinInfo.smsCallMode!.securityChangeCallAlarm = isOn;
        } else {
          tempRabinInfo.smsCallMode!.securityChangeSmsAlarm = isOn;
        }
        break;
      case CarSettingRabinNotificationType.securityWarningsAlarm:
        tempRabinInfo.smsCallMode!.securityWarningsSmsAlarm = isOn;
        break;
      case CarSettingRabinNotificationType.mainPowerAlarm:
        if (isCall) {
          tempRabinInfo.smsCallMode!.mainPowerCallAlarm = isOn;
        } else {
          tempRabinInfo.smsCallMode!.mainPowerSmsAlarm = isOn;
        }
        break;
      case CarSettingRabinNotificationType.carOnAlarm:
        if (isCall) {
          tempRabinInfo.smsCallMode!.carOnCallAlarm = isOn;
        } else {
          tempRabinInfo.smsCallMode!.carOnSmsAlarm = isOn;
        }
        break;
      case CarSettingRabinNotificationType.accCutAlarm:
        if (isCall) {
          tempRabinInfo.smsCallMode!.accCutCallAlarm = isOn;
        } else {
          tempRabinInfo.smsCallMode!.accCutSmsAlarm = isOn;
        }
        break;
      case CarSettingRabinNotificationType.movementAlarm:
        if (isCall) {
          tempRabinInfo.smsCallMode!.movementCallAlarm = isOn;
        } else {
          tempRabinInfo.smsCallMode!.movementSmsAlarm = isOn;
        }
        break;
    }
    update();
  }

  void updateConcoxSetting(
    CarSettingConcoxNotificationType type,
    bool isOn,
  ) {
    switch (type) {
      case CarSettingConcoxNotificationType.vibration:
        tempConcoxAlarm.vibrationAlarm ??= ConcoxAlarmInfo();
        if (isOn) {
          tempConcoxAlarm.vibrationAlarm?.state = true;
        } else {
          tempConcoxAlarm.vibrationAlarm?.state = false;
        }
        break;
      case CarSettingConcoxNotificationType.accCut:
        tempConcoxAlarm.accAlarm ??= ConcoxAlarmInfo();
        if (isOn) {
          tempConcoxAlarm.accAlarm?.state = true;
        } else {
          tempConcoxAlarm.accAlarm?.state = false;
        }
        break;
      case CarSettingConcoxNotificationType.batteryCap:
        tempConcoxAlarm.batteryAlarm ??= ConcoxAlarmInfo();
        if (isOn) {
          tempConcoxAlarm.batteryAlarm?.state = true;
        } else {
          tempConcoxAlarm.batteryAlarm?.state = false;
        }
        break;
      case CarSettingConcoxNotificationType.emergency:
        tempConcoxAlarm.sosAlarm ??= ConcoxAlarmInfo();
        if (isOn) {
          tempConcoxAlarm.sosAlarm?.state = true;
        } else {
          tempConcoxAlarm.sosAlarm?.state = false;
        }
        break;
      case CarSettingConcoxNotificationType.geographicRadius:
        tempConcoxAlarm.movingAlarm ??= ConcoxAlarmInfo();
        if (isOn) {
          tempConcoxAlarm.movingAlarm?.state = true;
        } else {
          tempConcoxAlarm.movingAlarm?.state = false;
        }
        break;
      case CarSettingConcoxNotificationType.speed:
        tempConcoxAlarm.speedAlarm ??= ConcoxAlarmInfo();
        if (isOn) {
          tempConcoxAlarm.speedAlarm?.state = true;
        } else {
          tempConcoxAlarm.speedAlarm?.state = false;
        }
        break;
    }
    update();
  }

  void updateConcoxSettingAlarmType(
    CarSettingConcoxNotificationType type,
    int value,
  ) {
    switch (type) {
      case CarSettingConcoxNotificationType.vibration:
        tempConcoxAlarm.vibrationAlarm?.alarmType =
            CarSettingConcoxAlarmType.values.elementAt(value);
        break;
      case CarSettingConcoxNotificationType.geographicRadius:
        tempConcoxAlarm.movingAlarm?.alarmType =
            CarSettingConcoxAlarmType.values.elementAt(value);
        break;
      case CarSettingConcoxNotificationType.accCut:
      case CarSettingConcoxNotificationType.batteryCap:
      case CarSettingConcoxNotificationType.emergency:
      case CarSettingConcoxNotificationType.speed:
        break;
    }
    update();
  }

  void updateAppSetting(
    CarSettingAppNotificationType type,
    String sendType,
    bool isOn,
  ) {
    switch (type) {
      case CarSettingAppNotificationType.net:
        if (isOn) {
          tempSetting.net!.sendType!.add(sendType);
        } else {
          tempSetting.net!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.security:
        if (isOn) {
          tempSetting.securityAlarm!.sendType!.add(sendType);
        } else {
          tempSetting.securityAlarm!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.accOn:
        if (isOn) {
          tempSetting.mainPower!.sendType!.add(sendType);
        } else {
          tempSetting.mainPower!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.battery:
        if (isOn) {
          tempSetting.batteryCharge!.sendType!.add(sendType);
        } else {
          tempSetting.batteryCharge!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.gpsAntena:
        if (isOn) {
          tempSetting.gpsAntennaState!.sendType!.add(sendType);
        } else {
          tempSetting.gpsAntennaState!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.speed:
        if (isOn) {
          tempSetting.overSpeed!.sendType!.add(sendType);
        } else {
          tempSetting.overSpeed!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.powerRelay:
        if (isOn) {
          tempSetting.powerRelayState!.sendType!.add(sendType);
        } else {
          tempSetting.powerRelayState!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.fuelRelay:
        if (isOn) {
          tempSetting.fuelRelayState!.sendType!.add(sendType);
        } else {
          tempSetting.fuelRelayState!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.movement:
        if (isOn) {
          tempSetting.movement!.sendType!.add(sendType);
        } else {
          tempSetting.movement!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.acc:
        if (isOn) {
          tempSetting.acc!.sendType!.add(sendType);
        } else {
          tempSetting.acc!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.accConnection:
        if (isOn) {
          tempSetting.accWiringState!.sendType!.add(sendType);
        } else {
          tempSetting.accWiringState!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.emergency:
        if (isOn) {
          tempSetting.sos!.sendType!.add(sendType);
        } else {
          tempSetting.sos!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.simCharge:
        if (isOn) {
          tempSetting.simCharge!.sendType!.add(sendType);
        } else {
          tempSetting.simCharge!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.lastConnection:
        if (isOn) {
          tempSetting.lastPacket!.sendType!.add(sendType);
        } else {
          tempSetting.lastPacket!.sendType!.remove(sendType);
        }
        break;
      case CarSettingAppNotificationType.lastLocation:
        if (isOn) {
          tempSetting.lastTrack!.sendType!.add(sendType);
        } else {
          tempSetting.lastTrack!.sendType!.remove(sendType);
        }
        break;
    }
    update();
  }
}
