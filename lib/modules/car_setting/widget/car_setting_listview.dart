import 'package:flutter/material.dart';
import 'car_setting_item.dart';

class CarSettingListView extends StatelessWidget {
  const CarSettingListView({
    required this.deviceName,
    required this.onSettingPressed,
    super.key,
  });
  final String deviceName;
  final VoidCallback onSettingPressed;
  @override
  Widget build(BuildContext context) {
    // TODO onPressed
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .05),
      child: Column(
        children: [
          // _verticalSpacer(size),
          // CarSettingItem(
          //   title: 'مدیریت سوخت',
          //   icon: 'assets/car/fuel_row.svg',
          //   onPressed: () {},
          // ),
          _verticalSpacer(size),
          CarSettingItem(
            title: 'سرویس های ماشین',
            icon: 'assets/car/service_row.svg',
            onPressed: () {},
          ),
          // _verticalSpacer(size),
          // CarSettingItem(
          //   title: 'فرمان ها',
          //   icon: 'assets/car/command_row.svg',
          //   onPressed: () {},
          // ),
          _verticalSpacer(size),
          CarSettingItem(
            title: 'گزارش گیری',
            icon: 'assets/car/report_row.svg',
            onPressed: () {},
          ),
          _verticalSpacer(size),
          CarSettingItem(
            title: '$deviceName تنظیمات',
            icon: 'assets/car/setting_row.svg',
            onPressed: onSettingPressed,
          ),
          // _verticalSpacer(size),
          // CarSettingItem(
          //   title: 'محدوده های جغرافیایی',
          //   icon: 'assets/car/zone_row.svg',
          //   onPressed: () {},
          // ),
          // _verticalSpacer(size),
          // CarSettingItem(
          //   title: 'سفرها',
          //   icon: 'assets/car/travel_row.svg',
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }

  Widget _verticalSpacer(Size size) {
    return SizedBox(
      height: size.height * .013,
    );
  }
}
