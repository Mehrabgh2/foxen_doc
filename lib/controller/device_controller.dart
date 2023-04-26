import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:foxenapp/modules/car_setting/car_setting_emergency_number/controller/car_setting_emergency_number_controller.dart';
import 'package:foxenapp/modules/car_setting/car_setting_notification/controller/car_setting_notification_controller.dart';
import 'package:foxenapp/modules/car_setting/car_setting_relay/controller/car_setting_relay_controller.dart';
import '../enum/car_setting_sms_command_type.dart';
import '../modules/car_setting/car_setting_simcard/screen/car_setting_simcard_screen.dart';
import '../modules/car_setting/car_setting_sms_command/controller/car_setting_sms_command_controller.dart';
import '../enum/command_subtype.dart';
import '../enum/command_type.dart';
import '../enum/relay_types.dart';
import '../modules/car_security_history/screen/car_security_history_screen.dart';
import '../modules/map/controller/custom_map_controller.dart';
import '../modules/map/widget/map_sheet.dart';
import '../model/command.dart';
import '../model/request/command_request.dart';
import '../model/foxen_device.dart';
import '../model/setting_command.dart';
import '../service/car_service.dart';
import '../util/device_field_extractor.dart';
import '../util/command_factory.dart';
import '../util/constants.dart';
import '../util/setting_command_factory.dart';
import '../widget/dialog_box.dart';
import '../widget/overlay_toast.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceController extends GetxController {
  RxBool isBookmarkLoading = false.obs;
  RxBool isCommandLoading = false.obs;
  RxBool isSecurityLoading = false.obs;
  RxBool isMovementAlarmLoading = false.obs;
  RxBool isRelayAlarmLoading = false.obs;
  RxBool isWaitingForLastSetting = false.obs;
  RxBool isWaitingForLastSettingAlarms = false.obs;
  RxBool isWaitingForLastSecurity = false.obs;

  Socket? socket;
  RxList<FoxenDevice> devices = RxList([]);
  List<CommandRequest> commandRequests = [];
  List<int> commandIds = [];
  List<int> securityIds = [];
  List<int> settingCommandIds = [];
  bool isFirstGetVehicle = true;
  RxInt carouselPage = RxInt(0);
  CarouselController carouselController = CarouselController();

  void init(String token) {
    connectToWebSocket(token);
    listenToWebSocket();
  }

  void dismiss() {
    CustomMapController mapController = Get.find<CustomMapController>();
    mapController.markers.value.clear();
    mapController.selectedMarker.value = null;
    mapController.isMapScreen.value = true;
    mapController.isBottomSheetOpen.value = false;
    mapController.markers.refresh();
    mapController.selectedMarker.refresh();
    mapController.isMapScreen.refresh();
    mapController.isBottomSheetOpen.refresh();
    devices.value.clear();
    commandRequests.clear();
    securityIds.clear();
    settingCommandIds.clear();
    isFirstGetVehicle = true;
    carouselPage.value = 0;
    carouselController = CarouselController();
    isBookmarkLoading.value = false;
    isCommandLoading.value = false;
    isSecurityLoading.value = false;
    isMovementAlarmLoading.value = false;
    isRelayAlarmLoading.value = false;
    isBookmarkLoading.refresh();
    isCommandLoading.refresh();
    isSecurityLoading.refresh();
    isMovementAlarmLoading.refresh();
    isRelayAlarmLoading.refresh();
    devices.refresh();
    carouselPage.refresh();
    if (socket != null) {
      socket!.disconnect();
      socket!.dispose();
      socket = null;
    }
  }

  void connectToWebSocket(String token) {
    socket = io(
      '${Constants.SOCKET_BASE_URL}/?token=$token',
      OptionBuilder()
          .enableAutoConnect()
          .setTransports(['websocket'])
          .setPath('/ws/socket.io')
          .setTimeout(5000)
          .build(),
    );
  }

  void listenToWebSocket() {
    CustomMapController mapController = Get.find<CustomMapController>();
    if (socket != null) {
      socket!.onAny((event, data) {
        debugPrint('ASD event : $event');
        debugPrint('ASD data : $data');
      });
      socket!.on('connect', (data) {});
      socket!.on('disconnect', (data) {});
      socket!.on('auth', (data) {});
      socket!.on('vehicle', (data) {
        updateDevices(data[1], mapController);
      });
      socket!.on('lastTrack', (data) {
        updateLastTrack(Track.fromJson(data), mapController);
      });
      socket!.on('lastSecurity', (data) {
        if (isWaitingForLastSecurity.value) {
          OverlayToast.showSuccessMessage("دزدگیر با موفقیت بروزرسانی شد");
          updateIsWaitingForLastSecurity(false);
        }
        updateLastSecurity(Security.fromJson(data), mapController);
      });
      socket!.on('lastENV', (data) {
        updateLastENV(GPS.fromJson(data), data['vehicle_id']);
      });
      socket!.on('appSetting', (data) {
        updateAppSetting(Appsetting.fromJson(data['appSetting']),
            int.parse(data['vehicleId']));
      });
      socket!.on('vehicleSetting', (data) {
        updateVehicleSetting(
            Setting.fromJson(data['setting']), data['vehicle_id']);
      });
      socket!.on('updateVehicleSetting', (data) {
        updateVehicle(Vehicle.fromJson(data), data['_id']);
      });
      socket!.on('deviceSettingReq', (data) {});
      socket!.on('deviceSettingReqOK', (data) {
        OverlayToast.showSuccessMessage('دستگاه تنظیمات را دریافت کرد');
      });
      socket!.on('lastSetting', (data) {
        if (isWaitingForLastSettingAlarms.value) {
          updateIsWaitingForLastSettingAlarms(false);
        }
        if (isWaitingForLastSetting.value) {
          OverlayToast.showSuccessMessage(
              'تنظیمات دستگاه با موفقیت بروزرسانی شد');
          updateIsWaitingForLastSetting(false);
          if (Get.isRegistered<CarSettingNotificationController>()) {
            Get.back();
          } else if (Get.isRegistered<CarSettingEmergencyNumberController>()) {
            Get.back();
          } else if (Get.isRegistered<CarSettingRelayController>()) {
            Get.back();
          }
        }
        updateLastDeviceSetting(
            Info.fromJson(data['data']), data['vehicle_id']);
      });
      socket!.on('deviceOnlineStatus', (data) {
        updateDeviceOnlineStatus(data['online'], data['vehicle_id']);
      });
      socket!.on('deviceSimNumberChannel', (data) {
        updateSimNumber(data, data['vehicleId']);
      });
      socket!.on('deviceCommandReq', (data) {
        if (commandIds.contains(data['CMDID'])) {
          updateIsCommandLoading(true);
          addCommandRequest(data);
        } else if (securityIds.contains(data['CMDID'])) {
          updateIsSecurityLoading(true);
          addCommandRequest(data);
        }
      });
      socket!.on('deviceCommandReqOK', (data) {
        if (commandIds.contains(data['CMDID'])) {
          OverlayToast.showSuccessMessage("فرمان برای دستگاه ارسال شد");
        }
      });
      socket!.on('deviceCommandResp', (data) {
        bool isOk = data['ok'];
        if (!isWaitingForLastSecurity.value) {
          OverlayToast.showSuccessMessage("فرمان با موفقیت اجرا شد");
          // TODO in switch relay ok is false
          // if (isOk) {
          //   OverlayToast.showSuccessMessage("فرمان با موفقیت اجرا شد");
          // } else {
          //   OverlayToast.showFailureMessage("اجرای فرمان با شکست مواجه شد");
          // }
        }
        if (securityIds.contains(data['CMDID'])) {
          securityIds.remove(data['CMDID']);
          updateIsSecurityLoading(false);
        } else if (commandIds.contains(data['CMDID'])) {
          commandIds.remove(data['CMDID']);
          updateIsCommandLoading(false);
        }
      });
    }
  }

  void startTimeout() {
    Timer(const Duration(milliseconds: Constants.websocketTimeout), () {
      if (commandIds.isNotEmpty) {
        updateIsCommandLoading(false);
        OverlayToast.showFailureMessage("TODO Timeout message");
      }
      if (securityIds.isNotEmpty) {
        updateIsSecurityLoading(false);
        OverlayToast.showFailureMessage("TODO Timeout message");
      }
    });
  }

  void addCommandRequest(Map<String, dynamic> data) {
    CommandRequest commandRequest = CommandRequest.fromJson(data);
    commandRequests.add(commandRequest);
  }

  void navigateToDevice(BuildContext context, FoxenDevice device) async {
    CustomMapController mapController = Get.find<CustomMapController>();
    mapController.selectedMarker.value?.closeToolTip();
    await MapSheet.show(
      context: context,
      onMapTap: (map) {
        MapLauncher.showMarker(
          mapType: map.mapType,
          coords: Coords(
            device.lastDeviceStatus!.track!.value.gps!.loc!.coordinates!
                .elementAt(1)
                .toDouble(),
            device.lastDeviceStatus!.track!.value.gps!.loc!.coordinates!
                .elementAt(0)
                .toDouble(),
          ),
          title: DeviceFieldExtractor.getCarName(device),
        );
      },
    );
    mapController.selectedMarker.value?.openToolTip();
  }

  void turnOnBookmark(FoxenDevice device, bool showToast) async {
    updateIsBookmarkLoading(true);
    var response = await CarService.bookmark(
        DeviceFieldExtractor.getVehicleId(device).toString());
    response.fold((l) {
      if (showToast) {
        OverlayToast.showSuccessMessage('ماشین نشان شده تغییر یافت');
      }
      turnOffAllBookmarks();
      turnOnVehicleBookmark(
          DeviceFieldExtractor.getVehicleId(device).toString());
    }, (r) {
      if (showToast) {
        OverlayToast.showFailureMessage(r.message.first.message);
      }
    });
    updateIsBookmarkLoading(false);
  }

  void turnOffAllBookmarks() {
    for (var element in devices.value) {
      element.vehicle?.value.bookmark!.value = false;
      element.vehicle?.value.bookmark!.refresh();
    }
  }

  void turnOnVehicleBookmark(String vehicleId) {
    for (var element in devices.value) {
      if (element.vehicleId.toString() == vehicleId) {
        element.vehicle?.value.bookmark!.value = true;
        element.vehicle?.value.bookmark!.refresh();
      }
    }
  }

  void updateDevices(
      List jsonDevices, CustomMapController mapController) async {
    for (int i = 0; i < jsonDevices.length; i++) {
      FoxenDevice device = FoxenDevice.fromJson(jsonDevices.elementAt(i));
      await addCar(device, mapController);
    }
    if (isFirstGetVehicle) {
      isFirstGetVehicle = false;
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        mapController.showCarsArea();
      });
      animateToDevice(getBookmarkedVehicleIndex());
    }
    devices.refresh();
    mapController.update();
    update();
  }

  Future<void> addCar(
      FoxenDevice device, CustomMapController mapController) async {
    int deviceInListIndex = devices.value
        .indexWhere((element) => element.device?.id == device.device?.id);
    if (deviceInListIndex != -1) {
      devices[deviceInListIndex] = device;
    } else {
      devices.add(device);
      await mapController.addCarToMap(device, true);
    }
    devices.refresh();
    mapController.update();
    update();
  }

  void updateLastTrack(Track update, CustomMapController mapController) {
    FoxenDevice? updatedRequest = getUpdateRequestDevice(update.vehicleId ?? 0);
    if (updatedRequest != null) {
      updatedRequest.lastDeviceStatus?.track?.value = update;
      updatedRequest.lastDeviceStatus?.track?.refresh();
      mapController.updateCarTrack(update.vehicleId ?? 0, update);
    }
  }

  void updateLastSecurity(Security update, CustomMapController mapController) {
    FoxenDevice? updatedRequest =
        getUpdateRequestDevice(update.vehicle_id ?? 0);
    if (updatedRequest != null) {
      updatedRequest.lastDeviceStatus?.security?.value = update;
      updatedRequest.lastDeviceStatus?.security?.refresh();
    }
  }

  void updateLastENV(GPS update, num? vehicleId) {
    FoxenDevice? updatedRequest = getUpdateRequestDevice(vehicleId ?? 0);
    if (updatedRequest != null) {
      updatedRequest.lastDeviceStatus?.track?.value.gps = update;
      updatedRequest.lastDeviceStatus?.track?.refresh();
    }
  }

  void updateAppSetting(Appsetting update, num? vehicleId) {
    FoxenDevice? updatedRequest = getUpdateRequestDevice(vehicleId ?? 0);
    if (updatedRequest != null) {
      updatedRequest.vehicle?.value.appsetting?.value = update;
      updatedRequest.vehicle?.value.appsetting?.refresh();
    }
  }

  void updateVehicleSetting(Setting update, num? vehicleId) {
    FoxenDevice? updatedRequest = getUpdateRequestDevice(vehicleId ?? 0);
    if (updatedRequest != null) {
      updatedRequest.vehicle?.value.setting?.value = update;
      updatedRequest.vehicle?.value.setting?.refresh();
    }
  }

  void updateVehicle(Vehicle update, num? vehicleId) {
    CustomMapController mapController = Get.find<CustomMapController>();
    FoxenDevice? updatedRequest = getUpdateRequestDevice(vehicleId ?? 0);
    if (updatedRequest != null) {
      updatedRequest.vehicle?.value = update;
      updatedRequest.vehicle?.refresh();
      mapController.updateCarName(
          vehicleId, updatedRequest.vehicle?.value.identification?.name);
    }
  }

  void updateLastDeviceSetting(Info update, num? vehicleId) {
    FoxenDevice? updatedRequest = getUpdateRequestDevice(vehicleId ?? 0);
    if (updatedRequest != null) {
      updatedRequest.lastDeviceStatus?.setting?.value = update;
      updatedRequest.lastDeviceStatus?.setting?.refresh();
    }
  }

  void updateDeviceOnlineStatus(bool update, num? vehicleId) {
    FoxenDevice? updatedRequest = getUpdateRequestDevice(vehicleId ?? 0);
    if (updatedRequest != null) {
      updatedRequest.lastDeviceStatus?.online?.value = update;
      updatedRequest.lastDeviceStatus?.online?.refresh();
    }
  }

  void updateSimNumber(Map<String, dynamic> update, num? vehicleId) {
    FoxenDevice? updatedRequest = getUpdateRequestDevice(vehicleId ?? 0);
    if (updatedRequest != null) {
      updatedRequest.device?.simno?.value = update['newNo'];
    }
  }

  void sendCommand(Command command) {
    startTimeout();
    socket!.emitWithAck('sendCommand', command.toJson(), ack: (ack) {
      if (handleAck(ack)) {
        int cmdId = ack[1];
        switch (command.type) {
          case CommandType.command:
            commandIds.add(cmdId);
            break;
          case CommandType.security:
            securityIds.add(cmdId);
            break;
        }
      }
    });
  }

  void sendSettingCommand(SettingCommand command, [Function? onSucces]) {
    startTimeout();
    socket!.emitWithAck('sendSetting', command.toJson(), ack: (ack) {
      updateIsWaitingForLastSetting(true);
      if (handleAck(ack)) {
        if (onSucces != null) onSucces();
      }
    });
  }

  bool handleAck(dynamic ack) {
    if (ack == 'vehicle_not_found') {
      OverlayToast.showFailureMessage('ماشین مورد نظر پیدا نشد');
      return false;
    }
    return true;
  }

  void goToHistoryScreen(FoxenDevice device) async {
    Get.to(
      () => CarSecurityHistoryScreen(device: device),
      transition: Transition.rightToLeft,
    );
  }

  FoxenDevice? getUpdateRequestDevice(num vehicleId) => devices.value
      .firstWhereOrNull((element) => element.vehicle?.value.id == vehicleId);

  int getBookmarkedVehicleIndex() {
    int index = devices.indexWhere((element) =>
        element.vehicle != null && element.vehicle!.value.bookmark!.value);
    if (index == -1) {
      if (devices.isNotEmpty) {
        turnOnBookmark(devices.elementAt(0), false);
      }
      return 0;
    } else {
      return index;
    }
  }

  int getVehicleIndex(num? id) {
    if (id == null) return 0;
    int index = devices.indexWhere((element) => element.id == id);
    return index == -1 ? 0 : index;
  }

  String getBookmarkedVehicleName() {
    int index = getBookmarkedVehicleIndex();
    return DeviceFieldExtractor.getCarName(devices.elementAt(index));
  }

  void vehicleRelayInfoPressed(BuildContext context, FoxenDevice device) {
    if (device.vehicle?.value.appsetting != null) {
      switch (device.vehicle?.value.appsetting!.value.vehicleScreenType!) {
        case RelayType.power:
          DialogBox.showInfoDialog(
              context: context,
              info:
                  'با قطع کردن رله، اگر ماشین روشن باشد خاموش می شود، و اگر خاموش باشد، تا زمانی که مجددا رله را وصل کنید، روشن نمی شود');
          break;
        case RelayType.fuel:
          DialogBox.showInfoDialog(
              context: context,
              info:
                  'با قطع کردن رله، اگر ماشین روشن باشد خاموش می شود، و اگر خاموش باشد، تا زمانی که مجددا رله را وصل کنید، روشن نمی شود');
          break;
        case RelayType.movementAlarm:
          DialogBox.showInfoDialog(
            context: context,
            info: 'TODO',
          );
          break;
        case RelayType.powerAlarm:
          DialogBox.showInfoDialog(
            context: context,
            info: 'TODO',
          );
          break;
        case null:
          break;
      }
    } else {
      DialogBox.showInfoDialog(
          context: context,
          info:
              'با قطع کردن رله، اگر ماشین روشن باشد خاموش می شود، و اگر خاموش باشد، تا زمانی که مجددا رله را وصل کنید، روشن نمی شود');
    }
  }

  void setupSecurity() {
    launchUrl(
      Uri.parse(
          'https://shop.arshinco.com/car-security-system/arna-anti-theft-vehicle'),
    );
  }

  void switchMapRelay(BuildContext context, FoxenDevice device) async {
    if (DeviceFieldExtractor.getIsRelayNotAlarm(device)) {
      CustomMapController mapController = Get.find<CustomMapController>();
      mapController.selectedMarker.value?.closeToolTip();
      await DialogBox.showTurnOnRelayDialog(
        context: context,
        type: DeviceFieldExtractor.getMapRelayTypeString(device),
        isOn: !DeviceFieldExtractor.getMapRelayOn(device),
        isRelay: true,
        vehicle: DeviceFieldExtractor.getCarName(device),
        confirmPressed: () {
          CommandSubType? command;
          if (device.vehicle?.value.appsetting != null) {
            switch (device.vehicle?.value.appsetting!.value.mapScreenType!) {
              case RelayType.power:
                command = DeviceFieldExtractor.getMapRelayOn(device)
                    ? CommandSubType.turnOffRelay
                    : CommandSubType.turnOnRelay;
                break;
              case RelayType.fuel:
                command = DeviceFieldExtractor.getMapRelayOn(device)
                    ? CommandSubType.turnOffFuel
                    : CommandSubType.turnOnFuel;
                break;
              case RelayType.movementAlarm:
                break;
              case RelayType.powerAlarm:
                break;
              case null:
                break;
            }
          } else {
            command = DeviceFieldExtractor.getRelayIsPower(device)
                ? DeviceFieldExtractor.getMapRelayOn(device)
                    ? CommandSubType.turnOffRelay
                    : CommandSubType.turnOnRelay
                : DeviceFieldExtractor.getMapRelayOn(device)
                    ? CommandSubType.turnOffFuel
                    : CommandSubType.turnOnFuel;
          }
          if (command != null) {
            sendCommand(
              CommandFactory.createCommand(device, command),
            );
          }
          Get.back();
        },
      );
      mapController.selectedMarker.value?.openToolTip();
    } else {
      if (device.vehicle?.value.appsetting != null) {
        switch (device.vehicle?.value.appsetting!.value.mapScreenType!) {
          case RelayType.power:
            break;
          case RelayType.fuel:
            break;
          case RelayType.movementAlarm:
          case RelayType.powerAlarm:
            sendSettingCommand(
              SettingCommandFactory.createSpeedAlarmCommand(
                  device, !DeviceFieldExtractor.getVehicleRelayOn(device)),
            );
            break;
          case null:
            break;
        }
      }
    }
  }

  void switchVehicleRelay(
      BuildContext context, FoxenDevice device, bool value) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    bool isOnline = DeviceFieldExtractor.getDeviceOnlineStatus(device);
    bool isMobileOnline = connectivityResult != ConnectivityResult.none;
    if (isOnline && isMobileOnline) {
      DialogBox.showTurnOnRelayDialog(
        context: context,
        type: DeviceFieldExtractor.getVehicleRelayTypeString(device),
        isOn: value,
        isRelay: true,
        vehicle: DeviceFieldExtractor.getCarName(device),
        confirmPressed: () {
          CommandSubType command = DeviceFieldExtractor.getRelayIsPower(device)
              ? value
                  ? CommandSubType.turnOnRelay
                  : CommandSubType.turnOffRelay
              : value
                  ? CommandSubType.turnOnFuel
                  : CommandSubType.turnOffFuel;
          sendCommand(
            CommandFactory.createCommand(device, command),
          );
          Get.back();
        },
      );
    } else {
      CarSettingSmsCommandController smsCommandController =
          Get.put(CarSettingSmsCommandController(device: device));
      DialogBox.showTurnOnRelayWithSms(
        context: context,
        isMobile: !isMobileOnline,
        confirmPressed: () => smsCommandController.onSend(
          DeviceFieldExtractor.getRelayIsPower(device)
              ? value
                  ? CarSettingSmsCommandType.turnOnRelay
                  : CarSettingSmsCommandType.turnOffRelay
              : value
                  ? CarSettingSmsCommandType.turnOnFuel
                  : CarSettingSmsCommandType.turnOffRelay,
        ),
        secondConfirmPressed: () {
          CommandSubType command = DeviceFieldExtractor.getRelayIsPower(device)
              ? value
                  ? CommandSubType.turnOnRelay
                  : CommandSubType.turnOffRelay
              : value
                  ? CommandSubType.turnOnFuel
                  : CommandSubType.turnOffFuel;
          sendCommand(
            CommandFactory.createCommand(device, command),
          );
        },
      );
    }
  }

  void switchSecurity(BuildContext context, bool isOn, FoxenDevice device) {
    DialogBox.showTurnOnRelayDialog(
      context: context,
      type: 'دزدگیر',
      isRelay: false,
      isOn: isOn,
      vehicle: DeviceFieldExtractor.getCarName(device),
      confirmPressed: () {
        sendCommand(
          CommandFactory.createCommand(
            device,
            isOn ? CommandSubType.offCarwashMode : CommandSubType.onCarwashMode,
          ),
        );
        Get.back();
      },
    );
  }

  void callDevice(FoxenDevice device) {
    String? phoneNumber = DeviceFieldExtractor.getCarSimNumber(device);
    if (phoneNumber != null) {
      launchUrl(Uri.parse('tel:$phoneNumber'));
    } else {
      OverlayToast.showFailureMessage(
          'لطفا شماره دستگاه را در این قسمت وارد کنید');
      Get.to(
        () => CarSettingSimcardScreen(device: device),
        transition: Transition.rightToLeft,
      );
    }
  }

  void animateToDevice(int index) async {
    await carouselController.onReady;
    carouselController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
    );
  }

  void updateIsBookmarkLoading(bool value) {
    isBookmarkLoading.value = value;
    isBookmarkLoading.refresh();
    update();
  }

  void updateIsWaitingForLastSetting(bool value) {
    isWaitingForLastSetting.value = value;
    isWaitingForLastSetting.refresh();
    update();
  }

  void updateIsWaitingForLastSettingAlarms(bool value) {
    isMovementAlarmLoading.value = value;
    isMovementAlarmLoading.refresh();
    isRelayAlarmLoading.value = value;
    isRelayAlarmLoading.refresh();
    isWaitingForLastSettingAlarms.value = value;
    isWaitingForLastSettingAlarms.refresh();
    update();
  }

  void updateIsWaitingForLastSecurity(bool value) {
    isWaitingForLastSecurity.value = value;
    isWaitingForLastSecurity.refresh();
    update();
  }

  void updateIsSecurityLoading(bool value) {
    isSecurityLoading.value = value;
    isSecurityLoading.refresh();
    update();
  }

  void updateIsCommandLoading(bool value) {
    isCommandLoading.value = value;
    isCommandLoading.refresh();
    update();
  }

  void updateCarouselPage(int value) {
    carouselPage.value = value;
    carouselPage.refresh();
    update();
  }
}
