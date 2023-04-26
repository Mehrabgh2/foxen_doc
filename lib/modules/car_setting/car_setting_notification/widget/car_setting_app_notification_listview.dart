import 'package:flutter/material.dart';
import '../../../../enum/car_setting_app_notification_type.dart';
import 'car_setting_notification_item.dart';
import '../../../../model/foxen_device.dart';
import '../../../../widget/custom_text_field.dart';

class CarSettingAppNotificationListView extends StatelessWidget {
  const CarSettingAppNotificationListView({
    required this.device,
    required this.setting,
    required this.maxSpeedController,
    required this.simChargeController,
    required this.lastConnectionController,
    required this.lastLocationController,
    required this.onChanged,
    super.key,
  });
  final FoxenDevice device;
  final Setting setting;
  final TextEditingController maxSpeedController;
  final TextEditingController simChargeController;
  final TextEditingController lastConnectionController;
  final TextEditingController lastLocationController;
  final Function(CarSettingAppNotificationType, String, bool) onChanged;
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
          for (int i = 0; i < CarSettingAppNotificationType.values.length; i++)
            if (isShowItem(i))
              Column(
                children: [
                  CarSettingNotificationItem(
                    title: _getTitle(
                        CarSettingAppNotificationType.values.elementAt(i)),
                    info: _getInfo(
                        CarSettingAppNotificationType.values.elementAt(i)),
                    isOn: _getReminderOn(
                        CarSettingAppNotificationType.values.elementAt(i),
                        'webNotification'),
                    updateOn: (value) => onChanged(
                        CarSettingAppNotificationType.values.elementAt(i),
                        'webNotification',
                        value),
                    downChild: i == CarSettingAppNotificationType.speed.index
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: maxSpeedController,
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
                        : i == CarSettingAppNotificationType.simCharge.index
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: simChargeController,
                                      type: TextInputType.number,
                                      textAlign: TextAlign.right,
                                      leftWidget: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * .02,
                                        ),
                                        child: Text(
                                          'ریال',
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
                                      'شارژ',
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
                            : i ==
                                    CarSettingAppNotificationType
                                        .lastConnection.index
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: lastConnectionController,
                                          type: TextInputType.number,
                                          textAlign: TextAlign.right,
                                          leftWidget: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: size.width * .02,
                                            ),
                                            child: Text(
                                              'ساعت',
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
                                          'زمان',
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
                                : i ==
                                        CarSettingAppNotificationType
                                            .lastLocation.index
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: CustomTextField(
                                              controller:
                                                  lastLocationController,
                                              type: TextInputType.number,
                                              textAlign: TextAlign.right,
                                              leftWidget: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: size.width * .02,
                                                ),
                                                child: Text(
                                                  'ساعت',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'YekanBakh-Regular',
                                                    color:
                                                        const Color(0xFF8D8D8D),
                                                    fontSize: size.width * .025,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'زمان',
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
                  if (i < CarSettingAppNotificationType.values.length - 1)
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

  bool isShowItem(int i) {
    bool isSecurity = i == CarSettingAppNotificationType.security.index;
    bool haveSecurity = device.lastDeviceStatus != null &&
        device.lastDeviceStatus!.security != null;
    if (!isSecurity) return true;
    return haveSecurity;
  }

  String _getTitle(CarSettingAppNotificationType type) {
    switch (type) {
      case CarSettingAppNotificationType.net:
        return 'سرویس های ماشین';
      case CarSettingAppNotificationType.security:
        return 'دزدگیر';
      case CarSettingAppNotificationType.accOn:
        return 'وضعیت اتصال برق دستگاه';
      case CarSettingAppNotificationType.battery:
        return 'شارژ باتری';
      case CarSettingAppNotificationType.gpsAntena:
        return 'وضعیت اتصال آنتن GPS';
      case CarSettingAppNotificationType.speed:
        return 'سرعت';
      case CarSettingAppNotificationType.powerRelay:
        return 'وضعیت اتصال رله برق';
      case CarSettingAppNotificationType.fuelRelay:
        return 'وضعیت اتصال رله سوخت';
      case CarSettingAppNotificationType.movement:
        return 'حرکت';
      case CarSettingAppNotificationType.acc:
        return 'روشن یا خاموش شدن';
      case CarSettingAppNotificationType.accConnection:
        return 'وضعیت اتصال سیم ACC';
      case CarSettingAppNotificationType.emergency:
        return 'حالت اضطراری';
      case CarSettingAppNotificationType.simCharge:
        return 'شارژ سیمکارت';
      case CarSettingAppNotificationType.lastConnection:
        return 'آخرین ارتباط دستگاه';
      case CarSettingAppNotificationType.lastLocation:
        return 'آخرین موقعیت جغرافیایی';
    }
  }

  String _getInfo(CarSettingAppNotificationType type) {
    switch (type) {
      case CarSettingAppNotificationType.net:
        return 'TODO';
      case CarSettingAppNotificationType.security:
        return 'TODO';
      case CarSettingAppNotificationType.accOn:
        return 'TODO';
      case CarSettingAppNotificationType.battery:
        return 'TODO';
      case CarSettingAppNotificationType.gpsAntena:
        return 'TODO';
      case CarSettingAppNotificationType.speed:
        return 'TODO';
      case CarSettingAppNotificationType.powerRelay:
        return 'TODO';
      case CarSettingAppNotificationType.fuelRelay:
        return 'TODO';
      case CarSettingAppNotificationType.movement:
        return 'TODO';
      case CarSettingAppNotificationType.acc:
        return 'TODO';
      case CarSettingAppNotificationType.accConnection:
        return 'TODO';
      case CarSettingAppNotificationType.emergency:
        return 'TODO';
      case CarSettingAppNotificationType.simCharge:
        return 'TODO';
      case CarSettingAppNotificationType.lastConnection:
        return 'TODO';
      case CarSettingAppNotificationType.lastLocation:
        return 'TODO';
    }
  }

  bool _getReminderOn(CarSettingAppNotificationType type, String reminder) {
    switch (type) {
      case CarSettingAppNotificationType.net:
        return setting.net != null && setting.net!.sendType != null
            ? setting.net!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.security:
        return setting.securityAlarm != null &&
                setting.securityAlarm!.sendType != null
            ? setting.securityAlarm!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.accOn:
        return setting.mainPower != null && setting.mainPower!.sendType != null
            ? setting.mainPower!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.battery:
        return setting.batteryCharge != null &&
                setting.batteryCharge!.sendType != null
            ? setting.batteryCharge!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.gpsAntena:
        return setting.gpsAntennaState != null &&
                setting.gpsAntennaState!.sendType != null
            ? setting.gpsAntennaState!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.speed:
        return setting.overSpeed != null && setting.overSpeed!.sendType != null
            ? setting.overSpeed!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.powerRelay:
        return setting.powerRelayState != null &&
                setting.powerRelayState!.sendType != null
            ? setting.powerRelayState!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.fuelRelay:
        return setting.fuelRelayState != null &&
                setting.fuelRelayState!.sendType != null
            ? setting.fuelRelayState!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.movement:
        return setting.movement != null && setting.movement!.sendType != null
            ? setting.movement!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.acc:
        return setting.acc != null && setting.acc!.sendType != null
            ? setting.acc!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.accConnection:
        return setting.accWiringState != null &&
                setting.accWiringState!.sendType != null
            ? setting.accWiringState!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.emergency:
        return setting.sos != null && setting.sos!.sendType != null
            ? setting.sos!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.simCharge:
        return setting.simCharge != null && setting.simCharge!.sendType != null
            ? setting.simCharge!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.lastConnection:
        return setting.lastPacket != null &&
                setting.lastPacket!.sendType != null
            ? setting.lastPacket!.sendType!.contains(reminder)
            : false;
      case CarSettingAppNotificationType.lastLocation:
        return setting.lastTrack != null && setting.lastTrack!.sendType != null
            ? setting.lastTrack!.sendType!.contains(reminder)
            : false;
    }
  }
}
