import 'package:flutter/material.dart';
import '../../car_setting/car_setting_device_info/screen/car_setting_device_info_screen.dart';
import '../../car_setting/car_setting_relay/screen/car_setting_relay_screen.dart';
import '../../car_setting/car_setting_sms_command/screen/car_setting_sms_command_screen.dart';
import 'car_accent_option.dart';
import '../../car_setting/car_setting_custom_show/screen/car_setting_custom_show_screen.dart';
import '../../car_setting/car_setting_identification/screen/car_setting_identification_screen.dart';
import '../../car_setting/car_setting_odometer_history/screen/car_setting_odometer_history_screen.dart';
import '../../../model/foxen_device.dart';
import 'package:get/get.dart';

class SecondAccentOptions extends StatelessWidget {
  const SecondAccentOptions({
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
        vertical: size.height * .01,
        horizontal: size.width * .05,
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
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: CarAccentOption(
                  icon: Icons.airport_shuttle,
                  title: 'کیلومتر شمار',
                  onPressed: () => onPressedItem(
                    CarSettingOdometerHistoryScreen(
                      device: device,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * spacer,
              ),
              Expanded(
                child: CarAccentOption(
                  icon: Icons.power,
                  title: 'تنظیمات رله ها',
                  onPressed: () => onPressedItem(
                    CarSettingRelayScreen(device: device),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * spacer,
              ),
              Expanded(
                child: CarAccentOption(
                  icon: Icons.info,
                  title: 'اطلاعات دستگاه',
                  onPressed: () => onPressedItem(
                    CarSettingDeviceInfoScreen(
                      device: device,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * spacer,
              ),
              Expanded(
                child: CarAccentOption(
                  icon: Icons.info,
                  title: 'اطلاعات ماشین',
                  onPressed: () => onPressedItem(
                    CarSettingIdentificationScreen(
                      device: device,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: CarAccentOption(
                  icon: Icons.slideshow_rounded,
                  title: 'نمایش اختیاری',
                  onPressed: () => onPressedItem(
                    CarSettingCustomShowScreen(
                      device: device,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * spacer,
              ),
              Expanded(
                child: CarAccentOption(
                  icon: Icons.add_chart,
                  title: 'مالی',
                  onPressed: () => onPressedItem(
                    null,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * spacer,
              ),
              Expanded(
                child: CarAccentOption(
                  icon: Icons.sms,
                  title: 'دستورات پیامکی',
                  onPressed: () => onPressedItem(
                    CarSettingSmsCommandScreen(device: device),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onPressedItem(Widget? screen) => screen != null
      ? Get.to(() => screen, transition: Transition.rightToLeft)
      : null;
}
