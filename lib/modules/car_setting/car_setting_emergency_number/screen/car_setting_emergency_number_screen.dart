import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../model/foxen_device.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/home_appbar.dart';
import '../../widget/car_setting_info_row.dart';
import '../controller/car_setting_emergency_number_controller.dart';

class CarSettingEmergencyNumberScreen extends StatelessWidget {
  const CarSettingEmergencyNumberScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<CarSettingEmergencyNumberController>(
        init: CarSettingEmergencyNumberController(device: device),
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
                                      height: size.height * .01,
                                    ),
                                    CarSettingInfoRow(
                                      title: 'شماره های اضطراری',
                                      textController: controller.masterA,
                                      info: 'TODO',
                                    ),
                                    CarSettingInfoRow(
                                      title: '',
                                      textController: controller.masterB,
                                    ),
                                    CarSettingInfoRow(
                                      title: '',
                                      textController: controller.masterC,
                                    ),
                                    CarSettingInfoRow(
                                      title: '',
                                      textController: controller.masterD,
                                    ),
                                    CarSettingInfoRow(
                                      title: '',
                                      textController: controller.masterE,
                                    ),
                                    SizedBox(
                                      height: size.height * .01,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * .01,
                                    ),
                                    CarSettingInfoRow(
                                      title: 'شماره های اضطراری',
                                      textController: controller.sos1,
                                      info: 'TODO',
                                    ),
                                    CarSettingInfoRow(
                                      title: '',
                                      textController: controller.sos2,
                                    ),
                                    CarSettingInfoRow(
                                      title: '',
                                      textController: controller.sos3,
                                    ),
                                    CarSettingInfoRow(
                                      title: 'مرکز تماس',
                                      textController: controller.center,
                                      info: 'TODO',
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
                                  onTap: controller.submitSimcardNumber,
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
