import 'package:flutter/material.dart';
import '../../../../enum/car_setting_rabin_notification_type.dart';
import 'car_setting_rabin_notification_item.dart';
import '../../../../model/foxen_device.dart';
import '../../../../widget/custom_text_field.dart';

class CarSettingRabinNotificationListView extends StatelessWidget {
  const CarSettingRabinNotificationListView({
    required this.device,
    required this.smsCallMode,
    required this.speedThresholdController,
    required this.simcardMncController,
    required this.onChanged,
    super.key,
  });
  final FoxenDevice device;
  final SmsCallMode smsCallMode;
  final TextEditingController speedThresholdController;
  final TextEditingController simcardMncController;
  final Function(CarSettingRabinNotificationType, bool, bool) onChanged;
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
          for (int i = 0;
              i < CarSettingRabinNotificationType.values.length;
              i++)
            Column(
              children: [
                CarSettingRabinNotificationItem(
                  title: _getTitle(
                      CarSettingRabinNotificationType.values.elementAt(i)),
                  info: _getInfo(
                      CarSettingRabinNotificationType.values.elementAt(i)),
                  isCallOn: _getReminderOn(
                    CarSettingRabinNotificationType.values.elementAt(i),
                    true,
                  ),
                  updateCallOn: (value) => onChanged(
                      CarSettingRabinNotificationType.values.elementAt(i),
                      true,
                      value),
                  isSmsOn: _getReminderOn(
                    CarSettingRabinNotificationType.values.elementAt(i),
                    false,
                  ),
                  updateSmsOn: (value) => onChanged(
                      CarSettingRabinNotificationType.values.elementAt(i),
                      false,
                      value),
                  haveCall:
                      CarSettingRabinNotificationType.values.elementAt(i) !=
                          CarSettingRabinNotificationType.securityWarningsAlarm,
                  downChild: i ==
                          CarSettingRabinNotificationType.speedAlarm.index
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: speedThresholdController,
                                type: TextInputType.number,
                                textAlign: TextAlign.right,
                                leftWidget: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * .02,
                                  ),
                                  child: Text(
                                    'کیلومتر بر ساعت',
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
                                'حداکثر سرعت مجاز',
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
                        )
                      : i == CarSettingRabinNotificationType.movementAlarm.index
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: simcardMncController,
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
                            )
                          : null,
                ),
                if (i < CarSettingRabinNotificationType.values.length - 1)
                  Container(
                    color: const Color(0xFFE6E6E6),
                    height: 1.5,
                  )
              ],
            )
        ],
      ),
    );
  }

  String _getTitle(CarSettingRabinNotificationType type) {
    switch (type) {
      case CarSettingRabinNotificationType.speedAlarm:
        return 'سرعت';
      case CarSettingRabinNotificationType.sosAlarm:
        return 'وضعیت اضطراری';
      case CarSettingRabinNotificationType.securityChangeAlarm:
        return 'تغییر کنترل های دزدگیر';
      case CarSettingRabinNotificationType.securityWarningsAlarm:
        return 'هشدارهای دزدگیر';
      case CarSettingRabinNotificationType.mainPowerAlarm:
        return 'قطع برق دستگاه';
      case CarSettingRabinNotificationType.carOnAlarm:
        return 'روشن شدن ماشین';
      case CarSettingRabinNotificationType.accCutAlarm:
        return 'قطع سیم ACC';
      case CarSettingRabinNotificationType.movementAlarm:
        return 'حرکت';
    }
  }

  String _getInfo(CarSettingRabinNotificationType type) {
    switch (type) {
      case CarSettingRabinNotificationType.speedAlarm:
        return 'TODO';
      case CarSettingRabinNotificationType.sosAlarm:
        return 'TODO';
      case CarSettingRabinNotificationType.securityChangeAlarm:
        return 'TODO';
      case CarSettingRabinNotificationType.securityWarningsAlarm:
        return 'TODO';
      case CarSettingRabinNotificationType.mainPowerAlarm:
        return 'TODO';
      case CarSettingRabinNotificationType.carOnAlarm:
        return 'TODO';
      case CarSettingRabinNotificationType.accCutAlarm:
        return 'TODO';
      case CarSettingRabinNotificationType.movementAlarm:
        return 'TODO';
    }
  }

  bool _getReminderOn(CarSettingRabinNotificationType type, bool isCall) {
    switch (type) {
      case CarSettingRabinNotificationType.speedAlarm:
        if (isCall) {
          return smsCallMode.speedCallAlarm ?? false;
        } else {
          return smsCallMode.speedSmsAlarm ?? false;
        }
      case CarSettingRabinNotificationType.sosAlarm:
        if (isCall) {
          return smsCallMode.sosCallAlarm ?? false;
        } else {
          return smsCallMode.sosSmsAlarm ?? false;
        }
      case CarSettingRabinNotificationType.securityChangeAlarm:
        if (isCall) {
          return smsCallMode.securityChangeCallAlarm ?? false;
        } else {
          return smsCallMode.securityChangeSmsAlarm ?? false;
        }
      case CarSettingRabinNotificationType.securityWarningsAlarm:
        return smsCallMode.securityWarningsSmsAlarm ?? false;
      case CarSettingRabinNotificationType.mainPowerAlarm:
        if (isCall) {
          return smsCallMode.mainPowerCallAlarm ?? false;
        } else {
          return smsCallMode.mainPowerSmsAlarm ?? false;
        }
      case CarSettingRabinNotificationType.carOnAlarm:
        if (isCall) {
          return smsCallMode.carOnCallAlarm ?? false;
        } else {
          return smsCallMode.carOnSmsAlarm ?? false;
        }
      case CarSettingRabinNotificationType.accCutAlarm:
        if (isCall) {
          return smsCallMode.accCutCallAlarm ?? false;
        } else {
          return smsCallMode.accCutSmsAlarm ?? false;
        }
      case CarSettingRabinNotificationType.movementAlarm:
        if (isCall) {
          return smsCallMode.movementCallAlarm ?? false;
        } else {
          return smsCallMode.movementSmsAlarm ?? false;
        }
    }
  }
}
