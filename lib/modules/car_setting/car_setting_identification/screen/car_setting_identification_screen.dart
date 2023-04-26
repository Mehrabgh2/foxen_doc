import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widget/car_setting_identification_plate_widget.dart';
import '../controller/car_setting_identification_controller.dart';
import '../../widget/car_setting_info_row.dart';
import '../../../../model/foxen_device.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/home_appbar.dart';
import 'package:get/get.dart';

class CarSettingIdentificationScreen extends StatelessWidget {
  const CarSettingIdentificationScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<CarSettingIdentificationController>(
        init: CarSettingIdentificationController(device: device),
        builder: (controller) {
          return Column(
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
                            CarSettingInfoRow(
                              title: 'عنوان',
                              textController: controller.nameController,
                            ),
                            CarSettingIdentificationPlateWidget(
                              first: controller.firstPlateController,
                              second: controller.secondPlate.value,
                              third: controller.thirdPlateController,
                              fourth: controller.fourthPlateController,
                              values: controller.persianAlphabets.value,
                              onChanged: controller.updateSecondPlate,
                            ),
                            CarSettingInfoRow(
                              title: '(شماره یکتای ماشین) VIN',
                              textController: controller.vinController,
                              info: 'TODO',
                            ),
                            CarSettingInfoRow(
                              title: 'نوع',
                              textController: controller.typeController,
                            ),
                            CarSettingInfoRow(
                              title: 'سال ساخت',
                              textController: controller.yearController,
                            ),
                            CarSettingInfoRow(
                              title: 'سازنده',
                              textController: controller.companyController,
                            ),
                            CarSettingInfoRow(
                              title: 'مدل',
                              textController: controller.modelController,
                            ),
                            CarSettingInfoRow(
                              title: 'بدنه',
                              textController: controller.bodyTypeController,
                            ),
                            CarSettingInfoRow(
                              title: 'شماره شاسی',
                              textController: controller.chassisController,
                              info: 'TODO',
                            ),
                            CarSettingInfoRow(
                              title: 'گروه',
                              textController: controller.groupController,
                            ),
                            CarSettingInfoRow(
                              title: 'راننده',
                              textController: controller.driverController,
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
                                onTap: controller.submitVehicleIdentification,
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
                      SizedBox(
                        height: size.height * .025,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
