import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foxenapp/enum/car_setting_concox_alarm_type.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/dialog_box.dart';

class CarSettingConcoxNotificationItem extends StatelessWidget {
  const CarSettingConcoxNotificationItem({
    required this.title,
    required this.isOn,
    required this.updateOn,
    required this.updateAlarmType,
    this.alarmType,
    this.info,
    this.upChild,
    super.key,
  });

  final String title;
  final String? info;
  final bool isOn;
  final Function(bool) updateOn;
  final Function(int) updateAlarmType;
  final CarSettingConcoxAlarmType? alarmType;
  final Widget? upChild;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * .015,
        horizontal: size.width * .04,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoSwitch(
                value: isOn,
                onChanged: (value) {
                  updateOn(value);
                },
                activeColor: const Color(0xFF189A93),
              ),
              const Expanded(child: SizedBox()),
              info != null
                  ? InkWell(
                      onTap: () => DialogBox.showInfoDialog(
                          context: context, info: info!),
                      child: const CustomSvgWidget('assets/car/info.svg'),
                    )
                  : const SizedBox(),
              SizedBox(
                width: size.width * .02,
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'YekanBakh-Bold',
                  color: const Color(0xFF32769E),
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * .0325,
                ),
              ),
            ],
          ),
          if (upChild != null)
            Column(
              children: [
                SizedBox(
                  height: size.height * .01,
                ),
                upChild!,
              ],
            ),
          SizedBox(
            height: size.height * .04,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: RadioListTile(
                activeColor: const Color(0xFF189A93),
                title: Text(
                  _getAlarmTypeTitle(CarSettingConcoxAlarmType.application),
                  style: TextStyle(
                    fontSize: size.width * .025,
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF565656),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                value: CarSettingConcoxAlarmType.application,
                groupValue: alarmType,
                onChanged: (value) {
                  updateAlarmType(0);
                },
              ),
            ),
          ),
          SizedBox(
            height: size.height * .04,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: RadioListTile(
                activeColor: const Color(0xFF189A93),
                title: Text(
                  _getAlarmTypeTitle(CarSettingConcoxAlarmType.applicationSms),
                  style: TextStyle(
                    fontSize: size.width * .025,
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF565656),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                value: CarSettingConcoxAlarmType.applicationSms,
                groupValue: alarmType,
                onChanged: (value) {
                  updateAlarmType(1);
                },
              ),
            ),
          ),
          SizedBox(
            height: size.height * .04,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: RadioListTile(
                activeColor: const Color(0xFF189A93),
                title: Text(
                  _getAlarmTypeTitle(
                      CarSettingConcoxAlarmType.applicationSmsCall),
                  style: TextStyle(
                    fontSize: size.width * .025,
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF565656),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                value: CarSettingConcoxAlarmType.applicationSmsCall,
                groupValue: alarmType,
                onChanged: (value) {
                  updateAlarmType(2);
                },
              ),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          )
        ],
      ),
    );
  }

  String _getAlarmTypeTitle(CarSettingConcoxAlarmType type) {
    switch (type) {
      case CarSettingConcoxAlarmType.application:
        return 'اطلاع رسانی از طریق اپلیکیشن';
      case CarSettingConcoxAlarmType.applicationSms:
        return 'اطلاع رسانی از طریق اپلیکیشن و ارسال پیامک';
      case CarSettingConcoxAlarmType.applicationSmsCall:
        return 'اطلاع رسانی از طریق اپلیکیشن و ارسال پیامک و تماس تلفنی';
    }
  }
}
