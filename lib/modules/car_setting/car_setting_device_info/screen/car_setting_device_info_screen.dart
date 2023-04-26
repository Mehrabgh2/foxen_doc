import 'package:flutter/material.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../controller/car_setting_device_info_controller.dart';
import '../widget/car_setting_device_info_row.dart';
import '../../../../model/foxen_device.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/home_appbar.dart';
import 'package:get/get.dart';

class CarSettingDeviceInfoScreen extends StatelessWidget {
  const CarSettingDeviceInfoScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<CarSettingDeviceInfoController>(
        init: CarSettingDeviceInfoController(device: device),
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
                        _getTitle(
                          size,
                          'اطلاعات دستگاه',
                          'assets/car/device_info.svg',
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: size.height * .02,
                            horizontal: size.width * .035,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * .01,
                            horizontal: size.width * .035,
                          ),
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
                              CarSettingDeviceInfoRow(
                                title: 'نوع',
                                value: DeviceFieldExtractor.getDeviceTypeString(
                                    device),
                              ),
                              CarSettingDeviceInfoRow(
                                title: 'شماره سریال',
                                value: DeviceFieldExtractor.getDeviceSerial(
                                    device),
                              ),
                              CarSettingDeviceInfoRow(
                                title: 'کد گارانتی',
                                value: DeviceFieldExtractor.getDeviceWarranty(
                                    device),
                              ),
                              CarSettingDeviceInfoRow(
                                title: 'تاریخ شروع گارانتی',
                                value: DeviceFieldExtractor
                                    .getDeviceStartWarrantyDate(device),
                              ),
                              CarSettingDeviceInfoRow(
                                title: 'تاریخ پایان گارانتی',
                                value: DeviceFieldExtractor
                                    .getDeviceEndWarrantyDate(device),
                              ),
                              CarSettingDeviceInfoRow(
                                title: 'ظرفیت باتری',
                                value: DeviceFieldExtractor.getDeviceBatteryCap(
                                    device),
                              ),
                              CarSettingDeviceInfoRow(
                                title: 'شماره فاکتور',
                                value: DeviceFieldExtractor.getDeviceFactor(
                                    device),
                              ),
                              CarSettingDeviceInfoRow(
                                title: 'نسخه نرم افزار',
                                value: DeviceFieldExtractor.getDeviceVersion(
                                    device),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .025,
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

  Widget _getTitle(Size size, String title, String icon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        size.width * .035,
        size.height * .02,
        size.width * .035,
        0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: size.width * .035,
              fontFamily: 'YekanBakh-Bold',
              color: const Color(0xFF32769E),
            ),
          ),
          SizedBox(
            width: size.width * .02,
          ),
          CustomSvgWidget(icon),
        ],
      ),
    );
  }
}
