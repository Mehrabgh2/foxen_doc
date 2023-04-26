import 'package:flutter/material.dart';
import '../../../../enum/car_setting_sms_command_type.dart';
import '../widget/car_setting_sms_command_row.dart';
import '../controller/car_setting_sms_command_controller.dart';
import '../../../../model/foxen_device.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/home_appbar.dart';
import 'package:get/get.dart';

class CarSettingSmsCommandScreen extends StatelessWidget {
  const CarSettingSmsCommandScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<CarSettingSmsCommandController>(
        init: CarSettingSmsCommandController(device: device),
        builder: (controller) {
          return Column(
            children: [
              Obx(
                () => HomeAppBar(
                  title: 'تنظیمات',
                  title2: DeviceFieldExtractor.getCarName(device),
                  onBack: Get.back,
                ),
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
                              for (int i = 0;
                                  i < CarSettingSmsCommandType.values.length;
                                  i++)
                                Column(
                                  children: [
                                    CarSettingSmsCommandRow(
                                      command: controller.getCommand(
                                        CarSettingSmsCommandType.values
                                            .elementAt(i),
                                      ),
                                      title: controller.getTitle(
                                        CarSettingSmsCommandType.values
                                            .elementAt(i),
                                      ),
                                      onCopy: () => controller.copyCommand(
                                        CarSettingSmsCommandType.values
                                            .elementAt(i),
                                      ),
                                      onSend: () => controller.onSend(
                                          CarSettingSmsCommandType.values
                                              .elementAt(i)),
                                    ),
                                    if (i !=
                                        CarSettingSmsCommandType.values.length -
                                            1)
                                      Container(
                                        color: const Color(0xFFE6E6E6),
                                        height: 1,
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
          );
        },
      ),
    );
  }
}
