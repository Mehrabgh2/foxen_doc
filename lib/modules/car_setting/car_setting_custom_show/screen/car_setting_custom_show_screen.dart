import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/car_setting_custom_show_controller.dart';
import '../../../../model/foxen_device.dart';
import '../../../../model/request/app_setting_request.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/home_appbar.dart';
import 'package:get/get.dart';

class CarSettingCustomShowScreen extends StatelessWidget {
  const CarSettingCustomShowScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<CarSettingCustomShowController>(
        init: CarSettingCustomShowController(),
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
                          SizedBox(
                            height: size.height * .01,
                          ),
                          _getTitle(
                            size,
                            'هشدار حرکت',
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: size.width * .1,
                                      height: size.width * .1,
                                      child: IgnorePointer(
                                        ignoring:
                                            controller.movementMapLoading.value,
                                        child: Opacity(
                                          opacity: controller
                                                  .movementMapLoading.value
                                              ? .25
                                              : 1,
                                          child: CupertinoSwitch(
                                            value: DeviceFieldExtractor
                                                .getIsShowMovementAlarm(device),
                                            onChanged: (value) {
                                              controller.updateAppSetting(
                                                controller.movementMapLoading,
                                                DeviceFieldExtractor
                                                    .getVehicleId(device),
                                                AppSettingRequest(
                                                  relay: AppSettingRelayRequest(
                                                    type: DeviceFieldExtractor
                                                        .getRelayTypeString(
                                                            device),
                                                    mapScreen: DeviceFieldExtractor
                                                        .getRelayShowInMapScreen(
                                                            device),
                                                    vehicle: false,
                                                  ),
                                                  movement:
                                                      AppSettingRequestBody(
                                                    mapScreen: DeviceFieldExtractor
                                                        .getMovementShowInMapScreen(
                                                            device),
                                                    vehicle: value,
                                                  ),
                                                  acc: AppSettingRequestBody(
                                                    mapScreen: DeviceFieldExtractor
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
                                      'نمایش کلید در صفحه ماشین',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF757575),
                                      ),
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
                                            controller.movementCarLoading.value,
                                        child: Opacity(
                                          opacity: controller
                                                  .movementCarLoading.value
                                              ? .25
                                              : 1,
                                          child: CupertinoSwitch(
                                            value: DeviceFieldExtractor
                                                .getMovementShowInMapScreen(
                                                    device),
                                            onChanged: (value) {
                                              controller.updateAppSetting(
                                                controller.movementCarLoading,
                                                DeviceFieldExtractor
                                                    .getVehicleId(device),
                                                AppSettingRequest(
                                                  relay: AppSettingRelayRequest(
                                                    type: DeviceFieldExtractor
                                                        .getRelayTypeString(
                                                            device),
                                                    mapScreen: value
                                                        ? false
                                                        : DeviceFieldExtractor
                                                            .getRelayShowInMapScreen(
                                                                device),
                                                    vehicle: false,
                                                  ),
                                                  movement:
                                                      AppSettingRequestBody(
                                                    mapScreen: value,
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
                          SizedBox(
                            height: size.height * .035,
                          ),
                          _getTitle(
                            size,
                            'هشدار روشن شدن ماشین',
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: size.width * .1,
                                      height: size.width * .1,
                                      child: IgnorePointer(
                                        ignoring:
                                            controller.accMapLoading.value,
                                        child: Opacity(
                                          opacity:
                                              controller.accMapLoading.value
                                                  ? .25
                                                  : 1,
                                          child: CupertinoSwitch(
                                            value: DeviceFieldExtractor
                                                .getIsShowRelayAlarm(device),
                                            onChanged: (value) {
                                              controller.updateAppSetting(
                                                controller.accMapLoading,
                                                DeviceFieldExtractor
                                                    .getVehicleId(device),
                                                AppSettingRequest(
                                                  relay: AppSettingRelayRequest(
                                                    type: DeviceFieldExtractor
                                                        .getRelayTypeString(
                                                            device),
                                                    mapScreen: DeviceFieldExtractor
                                                        .getRelayShowInMapScreen(
                                                            device),
                                                    vehicle: false,
                                                  ),
                                                  movement:
                                                      AppSettingRequestBody(
                                                    mapScreen: DeviceFieldExtractor
                                                        .getMovementShowInMapScreen(
                                                            device),
                                                    vehicle: DeviceFieldExtractor
                                                        .getIsShowMovementAlarm(
                                                            device),
                                                  ),
                                                  acc: AppSettingRequestBody(
                                                    mapScreen: DeviceFieldExtractor
                                                        .getAccShowInMapScreen(
                                                            device),
                                                    vehicle: value,
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
                                      'نمایش کلید در صفحه ماشین',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF757575),
                                      ),
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
                                            controller.accCarLoading.value,
                                        child: Opacity(
                                          opacity:
                                              controller.accCarLoading.value
                                                  ? .25
                                                  : 1,
                                          child: CupertinoSwitch(
                                            value: DeviceFieldExtractor
                                                .getAccShowInMapScreen(device),
                                            onChanged: (value) {
                                              controller.updateAppSetting(
                                                controller.accCarLoading,
                                                DeviceFieldExtractor
                                                    .getVehicleId(device),
                                                AppSettingRequest(
                                                  relay: AppSettingRelayRequest(
                                                    type: DeviceFieldExtractor
                                                        .getRelayTypeString(
                                                            device),
                                                    mapScreen: value
                                                        ? false
                                                        : DeviceFieldExtractor
                                                            .getRelayShowInMapScreen(
                                                                device),
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
                                                    mapScreen: value,
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

  Widget _getTitle(Size size, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size.width * .035,
        fontFamily: 'YekanBakh-Bold',
        color: const Color(0xFF32769E),
      ),
    );
  }
}
