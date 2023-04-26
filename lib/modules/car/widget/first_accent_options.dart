import 'package:flutter/material.dart';
import '../../car_setting/car_setting_simcard/screen/car_setting_simcard_screen.dart';
import 'package:get/get.dart';
import 'car_accent_option.dart';
import '../../../model/foxen_device.dart';

class FirstAccentOptions extends StatelessWidget {
  const FirstAccentOptions({
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
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CarAccentOption(
              icon: Icons.sim_card,
              title: 'سیمکارت دستگاه',
              onPressed: () => onPressedItem(
                CarSettingSimcardScreen(device: device),
              ),
            ),
          ),
          SizedBox(
            width: size.width * spacer,
          ),
          Expanded(
            child: CarAccentOption(
              icon: Icons.report,
              title: 'گزارش گیری',
              onPressed: () => onPressedItem(null),
            ),
          ),
          SizedBox(
            width: size.width * spacer,
          ),
          Expanded(
            child: CarAccentOption(
              icon: Icons.design_services,
              title: 'سرویس ها',
              onPressed: () => onPressedItem(null),
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
