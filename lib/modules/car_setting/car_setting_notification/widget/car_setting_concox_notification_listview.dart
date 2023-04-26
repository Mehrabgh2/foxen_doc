import 'package:flutter/material.dart';
import 'package:foxenapp/enum/car_setting_concox_alarm_type.dart';
import 'package:foxenapp/enum/car_setting_concox_notification_type.dart';
import 'package:foxenapp/modules/car_setting/car_setting_notification/widget/car_setting_concox_notification_accent_item.dart';
import 'package:foxenapp/modules/car_setting/car_setting_notification/widget/car_setting_notification_item.dart';
import 'car_setting_concox_notification_item.dart';
import '../../../../model/foxen_device.dart';
import '../../../../widget/custom_text_field.dart';

class CarSettingConcoxNotificationListView extends StatelessWidget {
  const CarSettingConcoxNotificationListView({
    required this.device,
    required this.alarm,
    required this.speedThresholdController,
    required this.speedThresholdTimeController,
    required this.movementRadiusController,
    required this.onChanged,
    required this.onChangedAlarmType,
    super.key,
  });
  final FoxenDevice device;
  final ConcoxAlarm alarm;
  final TextEditingController speedThresholdController;
  final TextEditingController speedThresholdTimeController;
  final TextEditingController movementRadiusController;
  final Function(CarSettingConcoxNotificationType, bool) onChanged;
  final Function(CarSettingConcoxNotificationType, int) onChangedAlarmType;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * .02,
        horizontal: size.width * .05,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(140),
            spreadRadius: -2,
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        children: [
          CarSettingConcoxNotificationItem(
            title: _getTitle(CarSettingConcoxNotificationType.vibration),
            info: _getInfo(CarSettingConcoxNotificationType.vibration),
            isOn: _getReminderOn(CarSettingConcoxNotificationType.vibration),
            updateOn: (value) => onChanged(
              CarSettingConcoxNotificationType.vibration,
              value,
            ),
            updateAlarmType: (value) => onChangedAlarmType(
              CarSettingConcoxNotificationType.vibration,
              value,
            ),
            alarmType:
                _getAlarmType(CarSettingConcoxNotificationType.vibration),
          ),
          _spacer(size),
          CarSettingNotificationItem(
            title: _getTitle(CarSettingConcoxNotificationType.accCut),
            info: _getInfo(CarSettingConcoxNotificationType.accCut),
            isOn: _getReminderOn(CarSettingConcoxNotificationType.accCut),
            updateOn: (value) => onChanged(
              CarSettingConcoxNotificationType.accCut,
              value,
            ),
          ),
          _spacer(size),
          CarSettingNotificationItem(
            title: _getTitle(CarSettingConcoxNotificationType.batteryCap),
            info: _getInfo(CarSettingConcoxNotificationType.batteryCap),
            isOn: _getReminderOn(CarSettingConcoxNotificationType.batteryCap),
            updateOn: (value) => onChanged(
              CarSettingConcoxNotificationType.batteryCap,
              value,
            ),
          ),
          _spacer(size),
          CarSettingNotificationItem(
            title: _getTitle(CarSettingConcoxNotificationType.emergency),
            info: _getInfo(CarSettingConcoxNotificationType.emergency),
            isOn: _getReminderOn(CarSettingConcoxNotificationType.emergency),
            updateOn: (value) => onChanged(
              CarSettingConcoxNotificationType.emergency,
              value,
            ),
          ),
          _spacer(size),
          CarSettingConcoxNotificationItem(
            title: _getTitle(CarSettingConcoxNotificationType.geographicRadius),
            info: _getInfo(CarSettingConcoxNotificationType.geographicRadius),
            isOn: _getReminderOn(
                CarSettingConcoxNotificationType.geographicRadius),
            updateOn: (value) => onChanged(
              CarSettingConcoxNotificationType.geographicRadius,
              value,
            ),
            updateAlarmType: (value) => onChangedAlarmType(
              CarSettingConcoxNotificationType.geographicRadius,
              value,
            ),
            alarmType: _getAlarmType(
                CarSettingConcoxNotificationType.geographicRadius),
            upChild: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: movementRadiusController,
                    type: TextInputType.number,
                    textAlign: TextAlign.right,
                    leftWidget: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * .02,
                      ),
                      child: Text(
                        'متر',
                        style: TextStyle(
                          fontFamily: 'YekanBakh-Regular',
                          color: const Color(0xFF8D8D8D),
                          fontSize: size.width * .025,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'شعاع جغرافیایی',
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF828282),
                      fontSize: size.width * .03,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _spacer(size),
          CarSettingConcoxNotificationAccentItem(
            title: _getTitle(CarSettingConcoxNotificationType.speed),
            info: _getInfo(CarSettingConcoxNotificationType.speed),
            isOn: _getReminderOn(CarSettingConcoxNotificationType.speed),
            updateOn: (value) => onChanged(
              CarSettingConcoxNotificationType.speed,
              value,
            ),
            maxSpeedController: speedThresholdController,
            timeSpeedController: speedThresholdTimeController,
          ),
        ],
      ),
    );
  }

  Widget _spacer(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * .075),
      color: const Color(0xFFE6E6E6),
      height: 1.5,
    );
  }

  String _getTitle(CarSettingConcoxNotificationType type) {
    switch (type) {
      case CarSettingConcoxNotificationType.vibration:
        return 'هشدار لرزش';
      case CarSettingConcoxNotificationType.accCut:
        return 'هشدار قطع برق دستگاه';
      case CarSettingConcoxNotificationType.batteryCap:
        return 'هشدار سطح باتری دستگاه';
      case CarSettingConcoxNotificationType.emergency:
        return 'هشدار حالت اضطراری';
      case CarSettingConcoxNotificationType.geographicRadius:
        return 'هشدار حرکت بر اساس فاصله از مرکز';
      case CarSettingConcoxNotificationType.speed:
        return 'هشدار حرکت بر اساس سرعت';
    }
  }

  String? _getInfo(CarSettingConcoxNotificationType type) {
    switch (type) {
      case CarSettingConcoxNotificationType.vibration:
        return 'TODO';
      case CarSettingConcoxNotificationType.accCut:
        return null;
      case CarSettingConcoxNotificationType.batteryCap:
        return 'TODO';
      case CarSettingConcoxNotificationType.emergency:
        return 'TODO';
      case CarSettingConcoxNotificationType.geographicRadius:
        return 'TODO';
      case CarSettingConcoxNotificationType.speed:
        return 'TODO';
    }
  }

  CarSettingConcoxAlarmType? _getAlarmType(
      CarSettingConcoxNotificationType type) {
    switch (type) {
      case CarSettingConcoxNotificationType.vibration:
        return alarm.vibrationAlarm?.alarmType;
      case CarSettingConcoxNotificationType.geographicRadius:
        return alarm.movingAlarm?.alarmType;
      case CarSettingConcoxNotificationType.accCut:
      case CarSettingConcoxNotificationType.batteryCap:
      case CarSettingConcoxNotificationType.emergency:
      case CarSettingConcoxNotificationType.speed:
        return null;
    }
  }

  bool _getReminderOn(CarSettingConcoxNotificationType type) {
    switch (type) {
      case CarSettingConcoxNotificationType.vibration:
        return alarm.vibrationAlarm != null
            ? alarm.vibrationAlarm!.state ?? false
            : false;
      case CarSettingConcoxNotificationType.accCut:
        return alarm.accAlarm != null ? alarm.accAlarm!.state ?? false : false;
      case CarSettingConcoxNotificationType.batteryCap:
        return alarm.batteryAlarm != null
            ? alarm.batteryAlarm!.state ?? false
            : false;
      case CarSettingConcoxNotificationType.emergency:
        return alarm.sosAlarm != null ? alarm.sosAlarm!.state ?? false : false;
      case CarSettingConcoxNotificationType.geographicRadius:
        return alarm.movingAlarm != null
            ? alarm.movingAlarm!.state ?? false
            : false;
      case CarSettingConcoxNotificationType.speed:
        return alarm.speedAlarm != null
            ? alarm.speedAlarm!.state ?? false
            : false;
    }
  }
}
