import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/dialog_box.dart';
import '../controller/car_setting_relay_controller.dart';
import '../../../../model/foxen_device.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/home_appbar.dart';
import 'package:get/get.dart';

class CarSettingRelayScreen extends StatelessWidget {
  const CarSettingRelayScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<CarSettingRelayController>(
        init: CarSettingRelayController(device: device),
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
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: size.height * .02,
                            horizontal: size.width * .035,
                          ),
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
                          child: DeviceFieldExtractor.deviceIsRabin(device)
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * .005,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: size.width * .1,
                                          height: size.width * .1,
                                          child: CupertinoSwitch(
                                            value: controller
                                                .tempRelayCutOff.value,
                                            onChanged: (value) {
                                              controller
                                                  .updateTempRelayCutOff(value);
                                            },
                                            activeColor:
                                                const Color(0xFF189A93),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  DialogBox.showInfoDialog(
                                                context: context,
                                                info: 'TODO',
                                              ),
                                              child: const CustomSvgWidget(
                                                  'assets/car/info.svg'),
                                            ),
                                            SizedBox(
                                              width: size.width * .02,
                                            ),
                                            Text(
                                              'رله جریان برق',
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
                                    SizedBox(
                                      height: size.height * .005,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: size.width * .1,
                                          height: size.width * .1,
                                          child: CupertinoSwitch(
                                            value: controller
                                                .tempSpareCutOff.value,
                                            onChanged: (value) {
                                              controller
                                                  .updateTempSpareCutOff(value);
                                            },
                                            activeColor:
                                                const Color(0xFF189A93),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  DialogBox.showInfoDialog(
                                                context: context,
                                                info: 'TODO',
                                              ),
                                              child: const CustomSvgWidget(
                                                  'assets/car/info.svg'),
                                            ),
                                            SizedBox(
                                              width: size.width * .02,
                                            ),
                                            Text(
                                              'رله جریان سوخت',
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
                                    SizedBox(
                                      height: size.height * .005,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: size.width * .1,
                                          height: size.width * .1,
                                          child: CupertinoSwitch(
                                            value: controller
                                                .tempConcoxRelay.value,
                                            onChanged: (value) {
                                              controller
                                                  .updateTempConcoxRelay(value);
                                            },
                                            activeColor:
                                                const Color(0xFF189A93),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  DialogBox.showInfoDialog(
                                                context: context,
                                                info: 'TODO',
                                              ),
                                              child: const CustomSvgWidget(
                                                  'assets/car/info.svg'),
                                            ),
                                            SizedBox(
                                              width: size.width * .02,
                                            ),
                                            Text(
                                              'وضعیت اتصال رله',
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
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        controller.isSubmitLoading.value
                            ? const SpinKitFadingCircle(
                                color: Colors.blue,
                              )
                            : Material(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xFF84C31E),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: controller.submit,
                                  child: SizedBox(
                                    width: size.width * .35,
                                    height: size.height * .05,
                                    child: Center(
                                      child: Text(
                                        'ثبت تغییرات',
                                        style: TextStyle(
                                          fontSize: size.width * .035,
                                          fontFamily: 'YekanBakh-Bold',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
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
