import 'package:flutter/material.dart';
import '../../car_setting/car_setting_emergency_number/screen/car_setting_emergency_number_screen.dart';
import 'car_primary_option.dart';
import '../../car_setting/car_setting_notification/screen/car_setting_notification_screen.dart';
import '../../car_setting/car_setting_service/screen/car_setting_service_screen.dart';
import '../../../model/foxen_device.dart';
import 'package:get/get.dart';

class FirstPrimaryOptions extends StatelessWidget {
  const FirstPrimaryOptions({
    required this.device,
    super.key,
  });
  final FoxenDevice device;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double spacer = .05;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * .05,
      ),
      padding: EdgeInsets.symmetric(
        vertical: size.height * .02,
        horizontal: size.width * .04,
      ),
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
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CarPrimaryOption(
              icon: Icons.sim_card,
              title: 'شماره های اضطراری',
              onPressed: () => onPressedItem(
                CarSettingEmergencyNumberScreen(device: device),
              ),
            ),
          ),
          SizedBox(
            width: size.width * spacer,
          ),
          Expanded(
            child: CarPrimaryOption(
              icon: Icons.report,
              title: 'تنظیم هشدارها',
              onPressed: () => onPressedItem(
                CarSettingNotificationScreen(device: device),
              ),
            ),
          ),
          SizedBox(
            width: size.width * spacer,
          ),
          Expanded(
            child: CarPrimaryOption(
              icon: Icons.design_services,
              title: 'تنظیمات سرویس',
              onPressed: () => onPressedItem(
                CarSettingServiceScreen(device: device),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPressedItem(Widget? screen) => screen != null
      ? Get.to(() => screen, transition: Transition.rightToLeft)
      : null;
}
