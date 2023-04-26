import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foxenapp/enum/device_type.dart';
import '../../widget/car_setting_info_row.dart';
import '../controller/car_setting_simcard_controller.dart';
import '../../../../model/foxen_device.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/home_appbar.dart';
import 'package:get/get.dart';

class CarSettingSimcardScreen extends StatelessWidget {
  const CarSettingSimcardScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<CarSettingSimcardController>(
        init: CarSettingSimcardController(device: device),
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
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * .01,
                              ),
                              if (DeviceFieldExtractor.deviceIsRabin(device))
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'ریال',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'YekanBakh-Regular',
                                              color: const Color(0xFF828282),
                                              fontSize: size.width * .03,
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * .01,
                                          ),
                                          Text(
                                            DeviceFieldExtractor
                                                .getCarSimCharge(device),
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'YekanBakh-Regular',
                                              color: const Color(0xFF828282),
                                              fontSize: size.width * .03,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'شارژ سیمکارت',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontFamily: 'YekanBakh-Regular',
                                          color: const Color(0xFF828282),
                                          fontSize: size.width * .03,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              CarSettingInfoRow(
                                title: 'شماره سیمکارت',
                                textController: controller.simCardController,
                              ),
                              SizedBox(
                                height: size.height * .01,
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
