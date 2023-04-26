import 'package:foxenapp/util/app_util.dart';
import '../enum/setting_command_type.dart';
import '../model/foxen_device.dart';
import '../model/setting_command.dart';

class SettingCommandFactory {
  static SettingCommand createMovementAlarmCommand(
      FoxenDevice device, bool value) {
    String deviceId = device.device?.mongoId ?? '';
    num vehicleId = device.lastDeviceStatus?.vehicleId ?? 0;
    int packetType = 2;
    Info info = device.lastDeviceStatus != null &&
            device.lastDeviceStatus!.setting != null
        ? device.lastDeviceStatus!.setting!.value
        : Info();
    num hex = device.lastDeviceStatus != null &&
            device.lastDeviceStatus!.setting != null &&
            device.lastDeviceStatus!.setting!.value.smsCallMode != null
        ? device.lastDeviceStatus!.setting!.value.smsCallMode!.hex ?? 0
        : 0;
    List<String> hexList = AppUtil.getBinList(hex);
    for (int i = hexList.length; i < 27; i++) {
      hexList.add('0');
    }
    hexList[25] = value ? '1' : '0';
    String joined = hexList.join();
    int newHex = int.parse(
        joined.isEmpty ? '0' : joined.split('').reversed.join(),
        radix: 2);
    info.smsCallMode != null
        ? info.smsCallMode!.hex = newHex
        : info.smsCallMode = SmsCallMode.fromHex(newHex);
    return SettingCommand(
      types: SettingCommandType.values,
      deviceId: deviceId,
      vehicleId: vehicleId,
      cmd: info.getCmds(),
      packetType: packetType,
    );
  }

  static SettingCommand createSpeedAlarmCommand(
      FoxenDevice device, bool value) {
    String deviceId = device.device?.mongoId ?? '';
    num vehicleId = device.lastDeviceStatus?.vehicleId ?? 0;
    int packetType = 2;
    Info info = device.lastDeviceStatus != null &&
            device.lastDeviceStatus!.setting != null
        ? device.lastDeviceStatus!.setting!.value
        : Info();
    num hex = device.lastDeviceStatus != null &&
            device.lastDeviceStatus!.setting != null &&
            device.lastDeviceStatus!.setting!.value.smsCallMode != null
        ? device.lastDeviceStatus!.setting!.value.smsCallMode!.hex ?? 0
        : 0;
    List<String> hexList = AppUtil.getBinList(hex);
    for (int i = hexList.length; i < 27; i++) {
      hexList.add('0');
    }
    hexList[15] = value ? '1' : '0';
    String joined = hexList.join();
    int newHex = int.parse(
        joined.isEmpty ? '0' : joined.split('').reversed.join(),
        radix: 2);
    info.smsCallMode != null
        ? info.smsCallMode!.hex = newHex
        : info.smsCallMode = SmsCallMode.fromHex(newHex);
    return SettingCommand(
      types: SettingCommandType.values,
      deviceId: deviceId,
      vehicleId: vehicleId,
      cmd: info.getCmds(),
      packetType: packetType,
    );
  }

  static SettingCommand createRelaysCommand(
      FoxenDevice device, bool relay, bool spare, Info info) {
    String deviceId = device.device?.mongoId ?? '';
    num vehicleId = device.lastDeviceStatus?.vehicleId ?? 0;
    int packetType = 2;
    num hex = device.lastDeviceStatus != null &&
            device.lastDeviceStatus!.setting != null &&
            device.lastDeviceStatus!.setting!.value.smsCallMode != null
        ? device.lastDeviceStatus!.setting!.value.smsCallMode!.hex ?? 0
        : 0;
    List<String> hexList = AppUtil.getBinList(hex);
    for (int i = hexList.length; i < 27; i++) {
      hexList.add('0');
    }
    hexList[2] = relay ? '1' : '0';
    hexList[24] = spare ? '1' : '0';
    String joined = hexList.join();
    int newHex = int.parse(
        joined.isEmpty ? '0' : joined.split('').reversed.join(),
        radix: 2);
    info.smsCallMode != null
        ? info.smsCallMode!.hex = newHex
        : info.smsCallMode = SmsCallMode.fromHex(newHex);
    return SettingCommand(
      types: SettingCommandType.values,
      deviceId: deviceId,
      vehicleId: vehicleId,
      cmd: info.getCmds(),
      packetType: packetType,
    );
  }

  static SettingCommand createRabinNotificationCommand(
    FoxenDevice device,
    Info info,
  ) {
    String deviceId = device.device?.mongoId ?? '';
    num vehicleId = device.lastDeviceStatus?.vehicleId ?? 0;
    int packetType = 2;
    num hex = device.lastDeviceStatus != null &&
            device.lastDeviceStatus!.setting != null &&
            device.lastDeviceStatus!.setting!.value.smsCallMode != null
        ? device.lastDeviceStatus!.setting!.value.smsCallMode!.hex ?? 0
        : 0;
    List<String> hexList = AppUtil.getBinList(hex);
    for (int i = hexList.length; i < 27; i++) {
      hexList.add('0');
    }
    hexList[0] = (info.smsCallMode?.sosCallAlarm ?? false) ? '1' : '0';
    hexList[1] = (info.smsCallMode?.sosSmsAlarm ?? false) ? '1' : '0';
    hexList[7] = (info.smsCallMode?.speedSmsAlarm ?? false) ? '1' : '0';
    hexList[8] =
        (info.smsCallMode?.securityChangeSmsAlarm ?? false) ? '1' : '0';
    hexList[9] =
        (info.smsCallMode?.securityChangeCallAlarm ?? false) ? '1' : '0';
    hexList[10] =
        (info.smsCallMode?.securityWarningsSmsAlarm ?? false) ? '1' : '0';
    hexList[13] = (info.smsCallMode?.mainPowerSmsAlarm ?? false) ? '1' : '0';
    hexList[14] = (info.smsCallMode?.accCutSmsAlarm ?? false) ? '1' : '0';
    hexList[15] = (info.smsCallMode?.carOnSmsAlarm ?? false) ? '1' : '0';
    hexList[20] = (info.smsCallMode?.speedCallAlarm ?? false) ? '1' : '0';
    hexList[21] = (info.smsCallMode?.mainPowerCallAlarm ?? false) ? '1' : '0';
    hexList[22] = (info.smsCallMode?.accCutCallAlarm ?? false) ? '1' : '0';
    hexList[23] = (info.smsCallMode?.carOnCallAlarm ?? false) ? '1' : '0';
    hexList[25] = (info.smsCallMode?.movementSmsAlarm ?? false) ? '1' : '0';
    hexList[26] = (info.smsCallMode?.movementCallAlarm ?? false) ? '1' : '0';
    String joined = hexList.join();
    int newHex = int.parse(
        joined.isEmpty ? '0' : joined.split('').reversed.join(),
        radix: 2);
    info.smsCallMode != null
        ? info.smsCallMode!.hex = newHex
        : info.smsCallMode = SmsCallMode.fromHex(newHex);
    return SettingCommand(
      types: SettingCommandType.values,
      deviceId: deviceId,
      vehicleId: vehicleId,
      cmd: info.getCmds(),
      packetType: packetType,
    );
  }

  static SettingCommand createMastersCommand(FoxenDevice device, Info info) {
    String deviceId = device.device?.mongoId ?? '';
    num vehicleId = device.lastDeviceStatus?.vehicleId ?? 0;
    int packetType = 2;
    return SettingCommand(
      types: SettingCommandType.values,
      deviceId: deviceId,
      vehicleId: vehicleId,
      cmd: info.getCmds(),
      packetType: packetType,
    );
  }

  static int getNewHex(num hex, int index, String value) {
    List hexList = AppUtil.getBinList(hex);
    if (hexList.length > index) {
      hexList[index] = value;
    } else {
      for (int i = hexList.length; i <= index; i++) {
        if (i == index) {
          hexList.add(value);
        } else {
          hexList.add('0');
        }
      }
    }
    String lastHex = (hexList.join());
    return int.parse(lastHex, radix: 2);
  }
}
