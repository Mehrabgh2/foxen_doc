import 'package:flutter/material.dart';
import 'package:foxenapp/modules/car_setting/car_setting_notification/widget/car_setting_concox_notification_listview.dart';
import 'package:foxenapp/modules/car_setting/widget/car_setting_submit_widget.dart';
import '../widget/car_setting_rabin_notification_listview.dart';
import '../controller/car_setting_notification_controller.dart';
import '../widget/car_setting_app_notification_listview.dart';
import '../../../../model/foxen_device.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/home_appbar.dart';
import 'package:get/get.dart';

class CarSettingNotificationScreen extends StatefulWidget {
  const CarSettingNotificationScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;

  @override
  State<CarSettingNotificationScreen> createState() =>
      _CarSettingNotificationScreenState();
}

class _CarSettingNotificationScreenState
    extends State<CarSettingNotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<CarSettingNotificationController>(
        init: CarSettingNotificationController(device: widget.device),
        builder: (controller) {
          return Column(
            children: [
              HomeAppBar(
                title: 'تنظیمات',
                title2: DeviceFieldExtractor.getCarName(widget.device),
                onBack: Get.back,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  size.width * .05,
                  size.height * .025,
                  size.width * .05,
                  size.height * .01,
                ),
                child: Container(
                  height: size.height * .052,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFE2E2E2),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2.0,
                        blurRadius: 20.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFF32769E),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF828282),
                      fontSize: size.width * .035,
                    ),
                    tabs: const [
                      Tab(
                        text: 'دستگاه',
                      ),
                      Tab(
                        text: 'فاکسن',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                  child: DeviceFieldExtractor.deviceIsRabin(
                                          widget.device)
                                      ? CarSettingRabinNotificationListView(
                                          device: widget.device,
                                          smsCallMode: controller
                                                  .tempRabinInfo.smsCallMode ??
                                              SmsCallMode(),
                                          speedThresholdController: controller
                                              .speedThresholdController,
                                          simcardMncController:
                                              controller.simcardMncController,
                                          onChanged:
                                              controller.updateRabinSetting,
                                        )
                                      : CarSettingConcoxNotificationListView(
                                          device: widget.device,
                                          alarm: controller.tempConcoxAlarm,
                                          speedThresholdController: controller
                                              .concoxMaxSpeedController,
                                          speedThresholdTimeController:
                                              controller
                                                  .concoxMaxSpeedTimeController,
                                          movementRadiusController: controller
                                              .concoxMovementRadiusController,
                                          onChanged:
                                              controller.updateConcoxSetting,
                                          onChangedAlarmType: controller
                                              .updateConcoxSettingAlarmType,
                                        ),
                                ),
                              ),
                              CarSettingSubmitWidget(
                                isLoading:
                                    controller.isDeviceSubmitLoading.value,
                                onPressed: controller.submitDeviceReminders,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                  child: CarSettingAppNotificationListView(
                                    device: widget.device,
                                    setting: controller.tempSetting,
                                    maxSpeedController:
                                        controller.maxSpeedController,
                                    simChargeController:
                                        controller.simChargeController,
                                    lastConnectionController:
                                        controller.lastConnectionController,
                                    lastLocationController:
                                        controller.lastLocationController,
                                    onChanged: controller.updateAppSetting,
                                  ),
                                ),
                              ),
                              CarSettingSubmitWidget(
                                isLoading: controller.isSubmitLoading.value,
                                onPressed: controller.submitReminders,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
