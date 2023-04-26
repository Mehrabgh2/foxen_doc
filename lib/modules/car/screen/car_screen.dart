import 'package:flutter/material.dart';
import '../../../controller/constants_prefrences_controller.dart';
import '../../../controller/device_controller.dart';
import '../../../enum/command_subtype.dart';
import '../../bottom_navigation/widget/custom_bottom_navigation.dart';
import '../widget/car_carousel_widget.dart';
import '../widget/car_second_card_view.dart';
import '../widget/car_security_card_view.dart';
import '../widget/car_security_control_bottom_sheet.dart';
import '../widget/first_accent_options.dart';
import '../widget/first_primary_options.dart';
import '../widget/second_accent_options.dart';
import '../../../model/foxen_device.dart';
import '../../../util/command_factory.dart';
import '../../../util/device_field_extractor.dart';
import '../../../util/setting_command_factory.dart';
import '../../../widget/custom_svg_widget.dart';
import '../../../widget/dialog_box.dart';
import 'package:get/get.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({
    required this.deviceController,
    required this.constantsPrefrencesController,
    super.key,
  });
  final DeviceController deviceController;
  final ConstantsPrefrencesController constantsPrefrencesController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget widget = Obx(
      () {
        FoxenDevice? device;
        bool hasSecurity = false;
        List<bool> states = [];
        if (deviceController.carouselPage.value !=
            deviceController.devices.length) {
          device = deviceController.devices
              .elementAt(deviceController.carouselPage.value);
          hasSecurity = device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.security != null;
        }
        bool showDontHaveSecurity =
            constantsPrefrencesController.constant.value.showDontHaveSecurity;
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CarCarouselWidget(
                page: deviceController.carouselPage.value,
                devices: deviceController.devices,
                onBookmarkPressed: (device) =>
                    DialogBox.showChangeBookmarkDialog(
                  context: context,
                  prevCar: deviceController.getBookmarkedVehicleName(),
                  newCar: DeviceFieldExtractor.getCarName(device),
                  confirmPressed: () =>
                      deviceController.turnOnBookmark(device, true),
                ),
                controller: deviceController.carouselController,
                onPageChanged: (value) =>
                    deviceController.updateCarouselPage(value),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              deviceController.carouselPage.value ==
                      deviceController.devices.length
                  ? const CustomSvgWidget(
                      'assets/car/add_car_background.svg',
                    )
                  : !hasSecurity && showDontHaveSecurity
                      ? const SizedBox()
                      : CarSecurityCardView(
                          isLoading: deviceController.isSecurityLoading.value,
                          device: device!,
                          hasSecurity: hasSecurity,
                          onDontShowAgain: () {
                            constantsPrefrencesController
                                .updateShowDontHaveSecurity(true);
                          },
                          onSetupSecurity: deviceController.setupSecurity,
                          onSecurityControlPressed: () {
                            states =
                                DeviceFieldExtractor.getSecurityControlStates(
                                    device!);
                            CarSecurityControlBottomSheet.show(
                              context: context,
                              isSecurityOn:
                                  DeviceFieldExtractor.getIsSecurityOn(device),
                              states: states,
                              onSecurityCommand: () =>
                                  deviceController.switchSecurity(
                                context,
                                !DeviceFieldExtractor.getIsSecurityOn(device!),
                                device,
                              ),
                              onHistoryPressed: () =>
                                  deviceController.goToHistoryScreen(device!),
                              onNewSecurity: (newStates) {
                                deviceController.sendCommand(
                                  CommandFactory.createSecurityCommand(
                                    device!,
                                    newStates,
                                  ),
                                );
                                deviceController
                                    .updateIsWaitingForLastSecurity(true);
                                if (states[6] != newStates[6]) {
                                  Future.delayed(
                                          const Duration(milliseconds: 500))
                                      .then((value) {
                                    deviceController.sendCommand(
                                      CommandFactory.createCommand(
                                        device!,
                                        newStates[6]
                                            ? CommandSubType.onCarwashMode
                                            : CommandSubType.offCarwashMode,
                                      ),
                                    );
                                  });
                                }
                              },
                            );
                          },
                          onCommand: (device, type) {
                            deviceController.sendCommand(
                              CommandFactory.createCommand(device, type),
                            );
                          },
                        ),
              SizedBox(
                height: size.height * .01,
              ),
              if (isAddCarItem)
                CarSecondCardView(
                  device: device!,
                  callDevice: deviceController.callDevice,
                  onRelayInfoPressed: () => deviceController
                      .vehicleRelayInfoPressed(context, device!),
                  onCallInfoPressed: () {
                    DialogBox.showInfoDialog(context: context, info: 'TODO');
                  },
                  relay: DeviceFieldExtractor.getVehicleRelayTypeString(device),
                  onRelayPressed: (value) => deviceController
                      .switchVehicleRelay(context, device!, value),
                  isRelayOn: DeviceFieldExtractor.getVehicleRelayOn(device),
                  showMovementAlarm:
                      DeviceFieldExtractor.getIsShowMovementAlarm(device),
                  showRelayAlarm:
                      DeviceFieldExtractor.getIsShowRelayAlarm(device),
                  isRelayAlarmOn:
                      DeviceFieldExtractor.getIsRelayAlarmOn(device),
                  isMovementAlarmOn:
                      DeviceFieldExtractor.getIsMovementAlarmOn(device),
                  isRelayAlarmLoading:
                      deviceController.isRelayAlarmLoading.value,
                  isMovementAlarmLoading:
                      deviceController.isMovementAlarmLoading.value,
                  isLoading: deviceController.isSecurityLoading.value,
                  onRelayAlarmPressed: (device, value) {
                    deviceController.updateIsWaitingForLastSettingAlarms(true);
                    deviceController.sendSettingCommand(
                      SettingCommandFactory.createSpeedAlarmCommand(
                          device, value),
                      () {},
                    );
                  },
                  onMovementAlarmPressed: (device, value) {
                    deviceController.updateIsWaitingForLastSettingAlarms(true);
                    deviceController.sendSettingCommand(
                      SettingCommandFactory.createMovementAlarmCommand(
                          device, value),
                      () {},
                    );
                  },
                ),
              SizedBox(
                height: size.height * .01,
              ),
              if (isAddCarItem) FirstAccentOptions(device: device!),
              SizedBox(
                height: size.height * .01,
              ),
              if (isAddCarItem) FirstPrimaryOptions(device: device!),
              SizedBox(
                height: size.height * .01,
              ),
              if (isAddCarItem) SecondAccentOptions(device: device!),
              if (isAddCarItem)
                SizedBox(
                  height: CustomBottomNavigation.height + size.height * .015,
                ),
            ],
          ),
        );
      },
    );
    deviceController
        .animateToDevice(deviceController.getBookmarkedVehicleIndex());
    return widget;
  }

  bool get isAddCarItem =>
      deviceController.carouselPage.value != deviceController.devices.length;
}
