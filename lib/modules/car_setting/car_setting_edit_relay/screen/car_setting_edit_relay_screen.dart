import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/car_setting_edit_relay_controller.dart';
import '../../../../model/foxen_device.dart';
import '../../../../model/request/app_setting_request.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/home_appbar.dart';
import 'package:get/get.dart';

class CarSettingEditRelayScreen extends StatelessWidget {
  const CarSettingEditRelayScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<CarSettingEditRelayController>(
        init: CarSettingEditRelayController(),
        builder: (controller) {
          return Obx(
            () => Column(
              children: [
                HomeAppBar(
                  title: 'تنظیمات',
                  title2: DeviceFieldExtractor.getCarName(device),
                  onBack: Get.back,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * .015,
                      horizontal: size.width * .05,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * .01,
                              horizontal: size.width * .035,
                            ),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withAlpha(100),
                                  spreadRadius: -2,
                                  blurRadius: 15,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IgnorePointer(
                                          ignoring:
                                              controller.fuelRadioLoading.value,
                                          child: Opacity(
                                            opacity: controller
                                                    .fuelRadioLoading.value
                                                ? .25
                                                : 1,
                                            child: Row(
                                              children: [
                                                Text(
                                                  'جریان سوخت',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize:
                                                        size.width * .0325,
                                                    fontFamily:
                                                        'YekanBakh-Regular',
                                                    color:
                                                        const Color(0xFF757575),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * .1,
                                                  height: size.width * .1,
                                                  child: Radio(
                                                    value: true,
                                                    groupValue:
                                                        !DeviceFieldExtractor
                                                            .getRelayIsPower(
                                                                device),
                                                    onChanged: (value) {
                                                      if (value == true) {
                                                        controller
                                                            .updateAppSetting(
                                                          controller
                                                              .fuelRadioLoading,
                                                          DeviceFieldExtractor.getVehicleId(device),
                                                          AppSettingRequest(
                                                            relay:
                                                                AppSettingRelayRequest(
                                                              type: 'fuel',
                                                              mapScreen:
                                                                  DeviceFieldExtractor
                                                                      .getRelayShowInMapScreen(
                                                                          device),
                                                              vehicle: false,
                                                            ),
                                                            movement:
                                                                AppSettingRequestBody(
                                                              mapScreen:
                                                                  DeviceFieldExtractor
                                                                      .getMovementShowInMapScreen(
                                                                          device),
                                                              vehicle: DeviceFieldExtractor
                                                                  .getIsShowMovementAlarm(
                                                                      device),
                                                            ),
                                                            acc:
                                                                AppSettingRequestBody(
                                                              mapScreen:
                                                                  DeviceFieldExtractor
                                                                      .getAccShowInMapScreen(
                                                                          device),
                                                              vehicle: DeviceFieldExtractor
                                                                  .getIsShowRelayAlarm(
                                                                      device),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    activeColor:
                                                        const Color(0xFF189A93),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        IgnorePointer(
                                          ignoring: controller
                                              .powerRadioLoading.value,
                                          child: Opacity(
                                            opacity: controller
                                                    .powerRadioLoading.value
                                                ? .25
                                                : 1,
                                            child: Row(
                                              children: [
                                                Text(
                                                  'جریان برق',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize:
                                                        size.width * .0325,
                                                    fontFamily:
                                                        'YekanBakh-Regular',
                                                    color:
                                                        const Color(0xFF757575),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * .1,
                                                  height: size.width * .1,
                                                  child: Radio(
                                                    value: true,
                                                    groupValue:
                                                        DeviceFieldExtractor
                                                            .getRelayIsPower(
                                                                device),
                                                    onChanged: (value) {
                                                      if (value == true) {
                                                        controller
                                                            .updateAppSetting(
                                                          controller
                                                              .powerRadioLoading,
                                                          DeviceFieldExtractor.getVehicleId(device),
                                                          AppSettingRequest(
                                                            relay:
                                                                AppSettingRelayRequest(
                                                              type: 'power',
                                                              mapScreen:
                                                                  DeviceFieldExtractor
                                                                      .getRelayShowInMapScreen(
                                                                          device),
                                                              vehicle: false,
                                                            ),
                                                            movement:
                                                                AppSettingRequestBody(
                                                              mapScreen:
                                                                  DeviceFieldExtractor
                                                                      .getMovementShowInMapScreen(
                                                                          device),
                                                              vehicle: DeviceFieldExtractor
                                                                  .getIsShowMovementAlarm(
                                                                      device),
                                                            ),
                                                            acc:
                                                                AppSettingRequestBody(
                                                              mapScreen:
                                                                  DeviceFieldExtractor
                                                                      .getAccShowInMapScreen(
                                                                          device),
                                                              vehicle: DeviceFieldExtractor
                                                                  .getIsShowRelayAlarm(
                                                                      device),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    activeColor:
                                                        const Color(0xFF189A93),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * .1,
                                    ),
                                    Row(
                                      children: [
                                        Opacity(
                                          opacity: 0,
                                          child: Radio(
                                            value: true,
                                            groupValue: true,
                                            onChanged: (value) {},
                                          ),
                                        ),
                                        Text(
                                          'نوع رله',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: size.width * .0325,
                                            fontFamily: 'YekanBakh-Regular',
                                            color: const Color(0xFF757575),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: size.width * .1,
                                      height: size.width * .1,
                                      child: IgnorePointer(
                                        ignoring:
                                            controller.relayMapLoading.value,
                                        child: Opacity(
                                          opacity:
                                              controller.relayMapLoading.value
                                                  ? .25
                                                  : 1,
                                          child: CupertinoSwitch(
                                            value: DeviceFieldExtractor
                                                .getRelayShowInMapScreen(
                                                    device),
                                            onChanged: (value) {
                                              controller.updateAppSetting(
                                                controller.relayMapLoading,
                                                DeviceFieldExtractor.getVehicleId(device),
                                                AppSettingRequest(
                                                  relay: AppSettingRelayRequest(
                                                    type: DeviceFieldExtractor
                                                        .getRelayTypeString(
                                                            device),
                                                    mapScreen: value,
                                                    vehicle: false,
                                                  ),
                                                  movement:
                                                      AppSettingRequestBody(
                                                    mapScreen: value
                                                        ? false
                                                        : DeviceFieldExtractor
                                                            .getMovementShowInMapScreen(
                                                                device),
                                                    vehicle: DeviceFieldExtractor
                                                        .getIsShowMovementAlarm(
                                                            device),
                                                  ),
                                                  acc: AppSettingRequestBody(
                                                    mapScreen: value
                                                        ? false
                                                        : DeviceFieldExtractor
                                                            .getAccShowInMapScreen(
                                                                device),
                                                    vehicle: DeviceFieldExtractor
                                                        .getIsShowRelayAlarm(
                                                            device),
                                                  ),
                                                ),
                                              );
                                            },
                                            activeColor:
                                                const Color(0xFF189A93),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'نمایش کلید در صفحه نقشه',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF757575),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
