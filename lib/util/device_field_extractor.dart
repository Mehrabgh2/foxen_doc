import '../enum/device_type.dart';
import '../enum/relay_types.dart';
import '../model/foxen_device.dart';
import 'constants.dart';

class DeviceFieldExtractor {
  static num getVehicleId(FoxenDevice device) => device.vehicleId ?? 0;

  static bool getRelayShowInMapScreen(FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle!.value.appsetting != null &&
              device.vehicle!.value.appsetting!.value.mapScreenType != null
          ? device.vehicle!.value.appsetting!.value.mapScreenType! ==
                  RelayType.power ||
              device.vehicle!.value.appsetting!.value.mapScreenType! ==
                  RelayType.fuel
          : false;

  static bool getMovementShowInMapScreen(FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle!.value.appsetting != null &&
              device.vehicle!.value.appsetting!.value.mapScreenType != null
          ? device.vehicle!.value.appsetting!.value.mapScreenType! ==
              RelayType.movementAlarm
          : false;

  static bool getAccShowInMapScreen(
          FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle!.value.appsetting != null &&
              device.vehicle!.value.appsetting!.value.mapScreenType != null
          ? device.vehicle!.value.appsetting!.value.mapScreenType! ==
              RelayType.powerAlarm
          : false;

  static String getMapRelayTypeString(FoxenDevice device) {
    if (device.vehicle != null && device.vehicle!.value.appsetting != null) {
      switch (device.vehicle!.value.appsetting!.value.mapScreenType!) {
        case RelayType.power:
          return 'جریان برق';
        case RelayType.fuel:
          return 'جریان سوخت';
        case RelayType.movementAlarm:
          return 'هشدار حرکت';
        case RelayType.powerAlarm:
          return 'هشدار روشن شدن';
      }
    } else {
      return getRelayIsPower(device) ? 'جریان برق' : 'جریان سوخت';
    }
  }

  static String getVehicleRelayTypeString(FoxenDevice device) {
    return getRelayIsPower(device) ? 'جریان برق' : 'جریان سوخت';
  }

  static bool getIsRelayNotAlarm(FoxenDevice device) {
    if (device.vehicle != null && device.vehicle!.value.appsetting != null) {
      switch (device.vehicle!.value.appsetting!.value.mapScreenType!) {
        case RelayType.power:
          return true;
        case RelayType.fuel:
          return true;
        case RelayType.movementAlarm:
          return false;
        case RelayType.powerAlarm:
          return false;
      }
    } else {
      return true;
    }
  }

  static bool getIsSecurityOn(FoxenDevice device) =>
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.security != null &&
              device.lastDeviceStatus!.security!.value.state != null
          ? device.lastDeviceStatus!.security!.value.state != 6
          : false;

  static bool getIsShowMovementAlarm(FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle!.value.appsetting != null &&
              device.vehicle!.value.appsetting!.value.movement != null
          ? device.vehicle!.value.appsetting!.value.movement!.vehicle ?? false
          : false;

  static bool getIsShowRelayAlarm(FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle!.value.appsetting != null &&
              device.vehicle!.value.appsetting!.value.acc != null
          ? device.vehicle!.value.appsetting!.value.acc!.vehicle ?? false
          : false;

  static bool getIsRelayAlarmOn(FoxenDevice device) => device.device != null &&
          device.lastDeviceStatus != null &&
          device.lastDeviceStatus!.setting != null &&
          device.lastDeviceStatus!.setting!.value.smsCallMode != null
      ? device.lastDeviceStatus!.setting!.value.smsCallMode!.powerAlarm ?? false
      : false;

  static bool getIsMovementAlarmOn(FoxenDevice device) =>
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.setting != null &&
              device.lastDeviceStatus!.setting!.value.smsCallMode != null
          ? device.lastDeviceStatus!.setting!.value.smsCallMode!
                  .movementAlarm ??
              false
          : false;

  static bool getIsCarAccOn(FoxenDevice device) =>
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.track != null &&
              device.lastDeviceStatus!.track!.value.statReg != null &&
              device.lastDeviceStatus!.track!.value.statReg!.accOn != null
          ? device.lastDeviceStatus!.track!.value.statReg!.accOn!
          : false;

  static num getCarSpeed(FoxenDevice device) =>
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.track != null &&
              device.lastDeviceStatus!.track!.value.gps != null &&
              device.lastDeviceStatus!.track!.value.gps!.speed != null
          ? device.lastDeviceStatus!.track!.value.gps!.speed!.toInt()
          : 0;

  static bool getIsRelayCutOff(FoxenDevice device) => device.lastDeviceStatus !=
              null &&
          device.lastDeviceStatus!.setting != null &&
          device.lastDeviceStatus!.setting!.value.smsCallMode != null &&
          device.lastDeviceStatus!.setting!.value.smsCallMode!.relayCutOff !=
              null
      ? device.lastDeviceStatus!.setting!.value.smsCallMode!.relayCutOff!
      : false;

  static bool getIsSpareCutOff(FoxenDevice device) => device.lastDeviceStatus !=
              null &&
          device.lastDeviceStatus!.setting != null &&
          device.lastDeviceStatus!.setting!.value.smsCallMode != null &&
          device.lastDeviceStatus!.setting!.value.smsCallMode!.spareCutOff !=
              null
      ? device.lastDeviceStatus!.setting!.value.smsCallMode!.spareCutOff!
      : false;

  static bool getIsConcoxRelay(FoxenDevice device) =>
      device.device != null && device.device!.info != null
          ? device.device!.info!.value.concoxRelay ?? false
          : false;

  static String getConcoxCenterNumber(FoxenDevice device) =>
      device.device != null && device.device!.info != null
          ? device.device!.info!.value.concoxCenterNumber ?? ''
          : '';

  static bool deviceIsRabin(FoxenDevice device) =>
      device.device != null &&
      (device.device!.productType ?? DeviceType.UNKNOWN) == DeviceType.RABIN;

  static String getConcoxSosNumber1(FoxenDevice device) =>
      device.device != null &&
              device.device!.info != null &&
              device.device!.info!.value.concoxSosNumbers != null &&
              device.device!.info!.value.concoxSosNumbers!.isNotEmpty
          ? (device.device!.info?.value.concoxSosNumbers!.elementAt(0) ?? '')
          : '';

  static String getConcoxSosNumber2(FoxenDevice device) =>
      device.device != null &&
              device.device!.info != null &&
              device.device!.info!.value.concoxSosNumbers != null &&
              device.device!.info!.value.concoxSosNumbers!.length > 1
          ? (device.device!.info?.value.concoxSosNumbers!.elementAt(1) ?? '')
          : '';

  static String getConcoxSosNumber3(FoxenDevice device) =>
      device.device != null &&
              device.device!.info != null &&
              device.device!.info!.value.concoxSosNumbers != null &&
              device.device!.info!.value.concoxSosNumbers!.length > 2
          ? (device.device!.info?.value.concoxSosNumbers!.elementAt(2) ?? '')
          : '';

  static String getDeviceTypeString(FoxenDevice device) {
    switch (device.device?.productType) {
      case DeviceType.RABIN:
        return 'رابین';
      case DeviceType.CONCOX:
        return 'کانکاکس';
      case DeviceType.TELTONIKA:
        return 'تلتونیکا';
      case DeviceType.UNKNOWN:
        return 'نامشخص';
      case null:
        return 'نامشخص';
    }
  }

  static String getDeviceSerial(FoxenDevice device) =>
      device.device?.serialNumber ?? '-';

  static String getDeviceWarranty(FoxenDevice device) =>
      device.device?.warrantyNumber ?? '-';

  static String getDeviceStartWarrantyDate(FoxenDevice device) =>
      device.device?.warrantyStartdate ?? '-';

  static String getDeviceEndWarrantyDate(FoxenDevice device) =>
      device.device?.warrantyEnddate ?? '-';

  static String getDeviceBatteryCap(FoxenDevice device) =>
      device.device?.batteryCap ?? '-';

  static String getDeviceFactor(FoxenDevice device) =>
      device.device?.factorno ?? '-';

  static String getDeviceVersion(FoxenDevice device) => '-';

  static bool getDeviceOnlineStatus(FoxenDevice device) =>
      device.lastDeviceStatus != null && device.lastDeviceStatus!.online != null
          ? device.lastDeviceStatus!.online!.value
          : false;

  static num getLastAccOff(FoxenDevice device) =>
      device.lastDeviceStatus?.lastAccOff ?? 0;

  static num getLastAccOn(FoxenDevice device) =>
      device.lastDeviceStatus?.lastAccOn ?? 0;

  static String getCarIcon(Track? track) {
    bool isAccConnected = track != null
        ? track.statReg != null
            ? track.statReg!.accConnected ?? false
            : false
        : false;
    bool isAccOn = track != null
        ? track.statReg != null
            ? track.statReg!.accOn ?? false
            : false
        : false;
    num speed = track != null
        ? track.gps != null
            ? (track.gps!.speed ?? 0)
            : 0
        : 0;
    String icon = '';
    if (isAccConnected) {
      if (isAccOn) {
        icon = 'green_car';
      } else if (!isAccOn && speed > 10) {
        icon = 'red_car';
      } else if (speed < 5) {
        icon = 'grey_car';
      } else {
        icon = 'grey_car';
      }
    } else {
      if (speed > 5) {
        icon = 'green_car';
      } else {
        icon = 'grey_car';
      }
    }
    return icon;
  }

  static String getCarName(FoxenDevice device) =>
      device.vehicle != null && device.vehicle!.value.identification != null
          ? device.vehicle!.value.identification!.name ?? ''
          : '';

  static String getCarVin(FoxenDevice device) =>
      device.vehicle != null && device.vehicle!.value.identification != null
          ? device.vehicle!.value.identification!.vin ?? ''
          : '';

  static String getCarType(FoxenDevice device) =>
      device.vehicle != null && device.vehicle!.value.identification != null
          ? device.vehicle!.value.identification!.type ?? ''
          : '';

  static String getCarYear(FoxenDevice device) =>
      device.vehicle != null && device.vehicle!.value.identification != null
          ? device.vehicle!.value.identification!.year ?? ''
          : '';

  static String getCarCompany(FoxenDevice device) =>
      device.vehicle != null && device.vehicle!.value.identification != null
          ? device.vehicle!.value.identification!.made ?? ''
          : '';

  static String getCarModel(FoxenDevice device) =>
      device.vehicle != null && device.vehicle!.value.identification != null
          ? device.vehicle!.value.identification!.model ?? ''
          : '';

  static String getCarBodyType(FoxenDevice device) =>
      device.vehicle != null && device.vehicle!.value.identification != null
          ? device.vehicle!.value.identification!.bodyType ?? ''
          : '';

  static String getCarChassis(FoxenDevice device) =>
      device.vehicle != null && device.vehicle!.value.identification != null
          ? device.vehicle!.value.identification!.chassis ?? ''
          : '';

  static String getCarGroup(FoxenDevice device) =>
      device.vehicle != null && device.vehicle!.value.classification != null
          ? device.vehicle!.value.classification!.group ?? ''
          : '';

  static String getCarDriver(FoxenDevice device) =>
      device.vehicle != null && device.vehicle!.value.classification != null
          ? device.vehicle!.value.classification!.driverId ?? ''
          : '';

  static String? getCarInfoImage(FoxenDevice device) => device.vehicle !=
              null &&
          device.vehicle!.value.identification != null &&
          device.vehicle!.value.identification!.photo != null &&
          device.vehicle!.value.identification!.photo!.name != null
      ? 'https://fms.arshinco.com/server10/${Constants.IMAGE_FOLDER_NAME}/${device.vehicle!.value.identification!.photo!.name}'
      : null;

  static String getCarOdometer(FoxenDevice device) =>
      device.vehicle != null && device.vehicle!.value.odometer != null
          ? device.vehicle!.value.odometer!.toStringAsFixed(0)
          : '0';

  static String? getCarSimNumber(FoxenDevice device) =>
      device.device != null && device.device!.simno != null
          ? device.device!.simno!.value
          : null;

  static String getCarSimCharge(FoxenDevice device) =>
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.track != null &&
              device.lastDeviceStatus!.track!.value.gsm != null &&
              device.lastDeviceStatus!.track!.value.gsm!.simCharge != null
          ? device.lastDeviceStatus!.track!.value.gsm!.simCharge!.toString()
          : '';

  static String getVehicleSimCharge(FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle!.value.setting != null &&
              device.vehicle!.value.setting!.value.simCharge != null &&
              device.vehicle!.value.setting!.value.simCharge!.value != null
          ? device.vehicle!.value.setting!.value.simCharge!.value!.toString()
          : '';

  static String getCarMaxSpeed(FoxenDevice device) => device.vehicle != null &&
          device.vehicle != null &&
          device.vehicle!.value.setting != null &&
          device.vehicle!.value.setting!.value.overSpeed != null &&
          device.vehicle!.value.setting!.value.overSpeed!.max != null
      ? device.vehicle!.value.setting!.value.overSpeed!.max!.toString()
      : '';

  static String getCarEarlyWarning(FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle!.value.setting != null &&
              device.vehicle!.value.setting!.value.net != null &&
              device.vehicle!.value.setting!.value.net!.earlyWarning != null
          ? device.vehicle!.value.setting!.value.net!.earlyWarning!.toString()
          : '';

  static String getCarEarlyWarningOdometer(FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle!.value.setting != null &&
              device.vehicle!.value.setting!.value.net != null &&
              device.vehicle!.value.setting!.value.net!.earlyWarningOdometer !=
                  null
          ? device.vehicle!.value.setting!.value.net!.earlyWarningOdometer!
              .toString()
          : '';

  static String getCarEarlyWarningTime(FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle!.value.setting != null &&
              device.vehicle!.value.setting!.value.net != null &&
              device.vehicle!.value.setting!.value.net!.time != null
          ? device.vehicle!.value.setting!.value.net!.time!.toString()
          : '';

  static bool getCarHiddenNet(FoxenDevice device) => device.vehicle != null &&
          device.vehicle!.value.setting != null &&
          device.vehicle!.value.setting!.value.net != null
      ? device.vehicle!.value.setting!.value.net!.hidden ?? false
      : false;

  static String getCarLastConnectionAlarm(FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle != null &&
              device.vehicle!.value.setting != null &&
              device.vehicle!.value.setting!.value.lastPacket != null &&
              device.vehicle!.value.setting!.value.lastPacket!.time != null
          ? (num.parse(device.vehicle!.value.setting!.value.lastPacket!.time!) /
                  3600)
              .floor()
              .toString()
          : '';

  static String getCarLastLocationAlarm(FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle != null &&
              device.vehicle!.value.setting != null &&
              device.vehicle!.value.setting!.value.lastTrack != null &&
              device.vehicle!.value.setting!.value.lastTrack!.time != null
          ? (num.parse(device.vehicle!.value.setting!.value.lastTrack!.time!) /
                  3600)
              .floor()
              .toString()
          : '';

  static String getCarSpeedThreshold(FoxenDevice device) =>
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.setting != null &&
              device.lastDeviceStatus!.setting!.value.speedThreshold != null
          ? device.lastDeviceStatus!.setting!.value.speedThreshold.toString()
          : '';

  static String getCarSimcardMNC(FoxenDevice device) =>
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.setting != null &&
              device.lastDeviceStatus!.setting!.value.simCardMNC != null
          ? device.lastDeviceStatus!.setting!.value.simCardMNC.toString()
          : '';

  static String getConcoxMaxSpeed(FoxenDevice device) => device.device !=
              null &&
          device.device!.info != null &&
          device.device!.info!.value.concoxAlarm != null &&
          device.device!.info!.value.concoxAlarm!.speedAlarm != null &&
          device.device!.info!.value.concoxAlarm!.speedAlarm!.speedLimit != null
      ? device.device!.info!.value.concoxAlarm!.speedAlarm!.speedLimit
          .toString()
      : '';

  static String getConcoxMaxSpeedTime(FoxenDevice device) => device.device !=
              null &&
          device.device!.info != null &&
          device.device!.info!.value.concoxAlarm != null &&
          device.device!.info!.value.concoxAlarm!.speedAlarm != null &&
          device.device!.info!.value.concoxAlarm!.speedAlarm!.detectionTime !=
              null
      ? device.device!.info!.value.concoxAlarm!.speedAlarm!.detectionTime
          .toString()
      : '';

  static String getConcoxMovementRadius(FoxenDevice device) => device.device !=
              null &&
          device.device!.info != null &&
          device.device!.info!.value.concoxAlarm != null &&
          device.device!.info!.value.concoxAlarm!.movingAlarm != null &&
          device.device!.info!.value.concoxAlarm!.movingAlarm!.radius != null
      ? device.device!.info!.value.concoxAlarm!.movingAlarm!.radius.toString()
      : '';

  static String getCarImage(FoxenDevice device) {
    String icon = 'assets/car/states/unlock.png';
    num? state = device.lastDeviceStatus != null &&
            device.lastDeviceStatus!.security != null
        ? device.lastDeviceStatus!.security!.value.state
        : null;
    SecurityInput? input = device.lastDeviceStatus != null &&
            device.lastDeviceStatus!.security != null
        ? device.lastDeviceStatus!.security!.value.input
        : null;
    if (state != null && input != null) {
      switch (state) {
        case 0:
          if (input.doorState ?? false) {
            icon = 'assets/car/states/door_open.png';
          } else {
            icon = 'assets/car/states/unlock.png';
          }
          break;
        case 1:
        case 2:
          icon = 'assets/car/states/lock.png';
          break;
        case 3:
          icon = 'assets/car/states/acc_on.png';
          break;
        case 4:
          if (input.doorState ?? false) {
            icon = 'assets/car/states/alarm_door_open.png';
          }
          if (input.trunkState ?? false) {
            icon = 'assets/car/states/alarm_door_open.png';
          }
          if (input.hoodState ?? false) {
            icon = 'assets/car/states/alarm_door_open.png';
          }
          if ((input.doorState ?? false) && (input.trunkState ?? false)) {
            icon = 'assets/car/states/alarm_door_open.png';
          }
          if ((input.doorState ?? false) && (input.hoodState ?? false)) {
            icon = 'assets/car/states/alarm_door_open.png';
          }
          if ((input.hoodState ?? false) && (input.trunkState ?? false)) {
            icon = 'assets/car/states/alarm_door_open.png';
          }
          if ((input.doorState ?? false) &&
              (input.hoodState ?? false) &&
              (input.trunkState ?? false)) {
            icon = 'assets/car/states/alarm_door_open.png';
          }
          if (input.shock ?? false) {
            icon = 'assets/car/states/shock.png';
          }
          if (input.ultra ?? false) {
            icon = 'assets/car/states/motion.png';
          }
          break;
        case 5:
          icon = 'assets/car/states/motion.png';
          break;
        case 6:
          icon = 'assets/car/states/carwash.png';
          break;
      }
      if (state != 4) {
        if (input.trunkState ?? false) {
          icon = 'assets/car/states/trunk.png';
        }
        // TODO add hood state
        // if (input.hoodState ?? false) {
        //   icon = 'assets/car/states/trunk.png';
        // }
        if ((input.doorState ?? false) && (input.trunkState ?? false)) {
          icon = 'assets/car/states/trunk_door.png';
        }
        if ((input.doorState ?? false) && (input.hoodState ?? false)) {
          icon = 'assets/car/states/trunk_door.png';
        }
        // TODO add trunk and hood state
        if ((input.hoodState ?? false) && (input.trunkState ?? false)) {
          icon = 'assets/car/states/trunk.png';
        }
        // TODO add trunk and hood and door state
        if ((input.doorState ?? false) &&
            (input.hoodState ?? false) &&
            (input.trunkState ?? false)) {
          icon = 'assets/car/states/trunk_door.png';
        }
      }
    } else {
      icon = 'assets/car/states/unlock.png';
    }
    return icon;
  }

  static List<bool> getSecurityControlStates(FoxenDevice device) {
    return [
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.security != null &&
              device.lastDeviceStatus!.security!.value.input != null
          ? device.lastDeviceStatus!.security!.value.input!.shock ?? false
          : false,
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.security != null &&
              device.lastDeviceStatus!.security!.value.input != null
          ? device.lastDeviceStatus!.security!.value.input!.flasherAccOn ??
              false
          : false,
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.security != null &&
              device.lastDeviceStatus!.security!.value.input != null
          ? device.lastDeviceStatus!.security!.value.input!.exitAlarmEg ?? false
          : false,
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.security != null &&
              device.lastDeviceStatus!.security!.value.input != null
          ? device.lastDeviceStatus!.security!.value.input!.ultra ?? false
          : false,
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.security != null &&
              device.lastDeviceStatus!.security!.value.input != null
          ? device.lastDeviceStatus!.security!.value.input!.childLock ?? false
          : false,
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.security != null &&
              device.lastDeviceStatus!.security!.value.input != null
          ? device.lastDeviceStatus!.security!.value.input!.optionKey ?? false
          : false,
      !getIsSecurityOn(device),
      device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.security != null &&
              device.lastDeviceStatus!.security!.value.input != null
          ? device.lastDeviceStatus!.security!.value.input!.autoLock ?? false
          : false,
    ];
  }

  static bool getRelayIsPower(FoxenDevice device) => device.vehicle != null &&
          device.vehicle!.value.appsetting != null
      ? device.vehicle!.value.appsetting!.value.relay != null
          ? (device.vehicle!.value.appsetting!.value.relay!.type ?? 'power') ==
                  'fuel'
              ? false
              : true
          : true
      : true;

  static String getRelayTypeString(FoxenDevice device) =>
      device.vehicle != null &&
              device.vehicle!.value.appsetting != null &&
              device.vehicle!.value.appsetting!.value.relay != null &&
              device.vehicle!.value.appsetting!.value.relay!.type != null
          ? device.vehicle!.value.appsetting!.value.relay!.type!
          : 'power';

  static bool getMapRelayOn(FoxenDevice device) {
    if (device.vehicle != null && device.vehicle!.value.appsetting != null) {
      switch (device.vehicle!.value.appsetting!.value.mapScreenType!) {
        case RelayType.power:
          return device.lastDeviceStatus != null &&
                  device.lastDeviceStatus!.track != null &&
                  device.lastDeviceStatus!.track!.value.statReg != null
              ? device.lastDeviceStatus!.track!.value.statReg!.powerRelayOn ??
                  false
              : false;
        case RelayType.fuel:
          return device.lastDeviceStatus != null &&
                  device.lastDeviceStatus!.track != null &&
                  device.lastDeviceStatus!.track!.value.statReg != null
              ? device.lastDeviceStatus!.track!.value.statReg!.fuelRelayOn ??
                  false
              : false;
        case RelayType.movementAlarm:
          return device.device != null &&
                  device.device!.info != null &&
                  device.device!.info!.value.smsCallMode != null
              ? device.device!.info!.value.smsCallMode!.movementAlarm ?? false
              : false;
        case RelayType.powerAlarm:
          return device.device != null &&
                  device.device!.info != null &&
                  device.device!.info!.value.smsCallMode != null
              ? device.device!.info!.value.smsCallMode!.powerAlarm ?? false
              : false;
      }
    } else {
      return device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.track != null
          ? device.lastDeviceStatus!.track!.value.statReg != null
              ? getRelayIsPower(device)
                  ? device.lastDeviceStatus!.track!.value.statReg!
                          .powerRelayOn ??
                      false
                  : device.lastDeviceStatus!.track!.value.statReg!
                          .fuelRelayOn ??
                      false
              : false
          : false;
    }
  }

  static bool getVehicleRelayOn(FoxenDevice device) {
    if (device.vehicle != null && device.vehicle!.value.appsetting != null) {
      switch (device.vehicle!.value.appsetting!.value.vehicleScreenType!) {
        case RelayType.power:
          return device.lastDeviceStatus != null &&
                  device.lastDeviceStatus!.track != null &&
                  device.lastDeviceStatus!.track!.value.statReg != null
              ? device.lastDeviceStatus!.track!.value.statReg!.powerRelayOn ??
                  false
              : false;
        case RelayType.fuel:
          return device.lastDeviceStatus != null &&
                  device.lastDeviceStatus!.track != null &&
                  device.lastDeviceStatus!.track!.value.statReg != null
              ? device.lastDeviceStatus!.track!.value.statReg!.fuelRelayOn ??
                  false
              : false;
        case RelayType.movementAlarm:
        case RelayType.powerAlarm:
          return device.lastDeviceStatus != null &&
                  device.lastDeviceStatus!.track != null
              ? device.lastDeviceStatus!.track!.value.statReg != null
                  ? getRelayIsPower(device)
                      ? device.lastDeviceStatus!.track!.value.statReg!
                              .powerRelayOn ??
                          false
                      : device.lastDeviceStatus!.track!.value.statReg!
                              .fuelRelayOn ??
                          false
                  : false
              : false;
      }
    } else {
      return device.lastDeviceStatus != null &&
              device.lastDeviceStatus!.track != null
          ? device.lastDeviceStatus!.track!.value.statReg != null
              ? getRelayIsPower(device)
                  ? device.lastDeviceStatus!.track!.value.statReg!
                          .powerRelayOn ??
                      false
                  : device.lastDeviceStatus!.track!.value.statReg!
                          .fuelRelayOn ??
                      false
              : false
          : false;
    }
  }
}
