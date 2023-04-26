import 'package:foxenapp/enum/car_setting_concox_alarm_type.dart';

import '../enum/device_type.dart';

import '../enum/relay_types.dart';
import '../util/app_util.dart';
import 'package:get/state_manager.dart';

class FoxenDevice {
  Device? device;
  Rx<Vehicle>? vehicle;
  num? userId;
  num? roleId;
  num? vehicleId;
  num? id;
  LastDeviceStatus? lastDeviceStatus;

  FoxenDevice({
    this.device,
    this.vehicle,
    this.userId,
    this.roleId,
    this.vehicleId,
    this.id,
    this.lastDeviceStatus,
  });

  factory FoxenDevice.fromJson(Map<String, dynamic> json) {
    final device =
        json['device'] == null ? null : Device.fromJson(json['device']);
    final vehicle =
        json['vehicle'] == null ? null : Rx(Vehicle.fromJson(json['vehicle']));
    final userId = json['user_id'];
    final roleId = json['role_id'];
    final vehicleId = json['vehicle_id'];
    final id = json['_id'];
    final lastDeviceStatus = json['lastDeviceStatus'] == null
        ? null
        : LastDeviceStatus.fromJson(json['lastDeviceStatus']);
    return FoxenDevice(
      device: device,
      vehicle: vehicle,
      userId: userId,
      roleId: roleId,
      vehicleId: vehicleId,
      id: id,
      lastDeviceStatus: lastDeviceStatus,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['device'] = device?.toJson();
    data['vehicle'] = vehicle?.toJson();
    data['user_id'] = userId;
    data['role_id'] = roleId;
    data['vehicle_id'] = vehicleId;
    data['_id'] = id;
    data['lastDeviceStatus'] = lastDeviceStatus?.toJson();
    return data;
  }
}

class Device {
  num? vehicleId;
  num? accountId;
  num? companyId;
  String? deviceId;
  String? serialNumber;
  String? warrantyNumber;
  String? warrantyStartdate;
  String? warrantyEnddate;
  String? batteryCap;
  String? features;
  String? timestamp;
  Rx<String>? simno;
  num? lasId;
  DeviceType? productType;
  String? factorno;
  String? mongoId;
  Rx<Info>? info;
  num? id;

  Device({
    this.vehicleId,
    this.accountId,
    this.companyId,
    this.deviceId,
    this.serialNumber,
    this.warrantyNumber,
    this.warrantyStartdate,
    this.warrantyEnddate,
    this.batteryCap,
    this.features,
    this.timestamp,
    this.simno,
    this.lasId,
    this.productType,
    this.factorno,
    this.mongoId,
    this.info,
    this.id,
  });

  Device.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicle_id'];
    accountId = json['account_id'];
    companyId = json['company_id'];
    deviceId = json['deviceid'];
    serialNumber = json['serialnumber'];
    warrantyNumber = json['warrantynumber'];
    warrantyStartdate = json['warrantystartdate'];
    warrantyEnddate = json['warrantyenddate'];
    batteryCap = json['batterycap'];
    features = json['features'];
    timestamp = json['timestamp'];
    simno = json['simno'] != null ? Rx(json['simno']) : null;
    lasId = json['las_id'];
    num tempProductType = json['producttype'];
    productType = DeviceType.UNKNOWN;
    switch (tempProductType) {
      case 0:
      case 1:
        productType = DeviceType.RABIN;
        break;
      case 2:
      case 3:
        productType = DeviceType.CONCOX;
        break;
      case 4:
      case 5:
        productType = DeviceType.TELTONIKA;
        break;
      default:
        break;
    }
    factorno = json['factorno'];
    mongoId = json['mongo_id'];
    info = json['info'] != null ? Rx(Info.fromJson(json['info'])) : null;
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicle_id'] = vehicleId;
    data['account_id'] = accountId;
    data['company_id'] = companyId;
    data['deviceid'] = deviceId;
    data['serialnumber'] = serialNumber;
    data['warrantynumber'] = warrantyNumber;
    data['warrantystartdate'] = warrantyStartdate;
    data['warrantyenddate'] = warrantyEnddate;
    data['batterycap'] = batteryCap;
    data['features'] = features;
    data['timestamp'] = timestamp;
    data['simno'] = simno;
    data['las_id'] = lasId;
    data['producttype'] = productType;
    data['factorno'] = factorno;
    data['mongo_id'] = mongoId;
    if (info != null) {
      data['info'] = info!.toJson();
    }
    data['_id'] = id;
    return data;
  }
}

class Info {
  String? id;
  String? apnName;
  num? masterA;
  num? masterB;
  num? masterC;
  num? masterD;
  num? masterE;
  num? maxTemp;
  num? minTemp;
  SmsCallMode? sendMode;
  String? serverIP;
  String? deviceId;
  num? acclRange;
  num? resetTime;
  num? deviceInfoId;
  num? timestamp;
  num? acclActive;
  String? serverPort;
  num? simCardMCC;
  num? simCardMNC;
  num? packetType;
  num? speedRatio;
  num? vehicleId;
  String? apnPassword;
  String? apnUserName;
  num? envPackTime;
  num? intSendTime;
  SmsCallMode? smsCallMode;
  num? maxHumidity;
  num? maxPressure;
  num? minHumidity;
  num? minPressure;
  num? autoPackTime;
  num? gsmResetTime;
  num? acclThreshold;
  num? autoPackCount;
  num? fuelThreshold;
  num? acclInactiveTm;
  num? speedThreshold;
  num? intSendDistance;
  String? answerValidation;
  num? recievedTimestamp;
  List<String>? concoxSosNumbers;
  ConcoxAlarm? concoxAlarm;
  String? concoxCenterNumber;
  bool? concoxRelay;

  Info({
    this.id,
    this.apnName,
    this.masterA,
    this.masterB,
    this.masterC,
    this.masterD,
    this.masterE,
    this.maxTemp,
    this.minTemp,
    this.sendMode,
    this.serverIP,
    this.deviceId,
    this.acclRange,
    this.resetTime,
    this.deviceInfoId,
    this.timestamp,
    this.acclActive,
    this.serverPort,
    this.simCardMCC,
    this.simCardMNC,
    this.packetType,
    this.speedRatio,
    this.vehicleId,
    this.apnPassword,
    this.apnUserName,
    this.envPackTime,
    this.intSendTime,
    this.smsCallMode,
    this.maxHumidity,
    this.maxPressure,
    this.minHumidity,
    this.minPressure,
    this.autoPackTime,
    this.gsmResetTime,
    this.acclThreshold,
    this.autoPackCount,
    this.fuelThreshold,
    this.acclInactiveTm,
    this.speedThreshold,
    this.intSendDistance,
    this.answerValidation,
    this.recievedTimestamp,
    this.concoxSosNumbers,
    this.concoxAlarm,
    this.concoxCenterNumber,
    this.concoxRelay,
  });

  Info.fromJson(Map<String, dynamic> json) {
    id = json['_id'] != null && json['_id'] != '' ? json['_id'] : null;
    apnName = json['APNName'] != null && json['APNName'] != ''
        ? json['APNName']
        : null;
    masterA = json['MasterA'] != null && json['MasterA'] != ''
        ? json['MasterA']
        : null;
    masterB = json['MasterB'] != null && json['MasterB'] != ''
        ? json['MasterB']
        : null;
    masterC = json['MasterC'] != null && json['MasterC'] != ''
        ? json['MasterC']
        : null;
    masterD = json['MasterD'] != null && json['MasterD'] != ''
        ? json['MasterD']
        : null;
    masterE = json['MasterE'] != null && json['MasterE'] != ''
        ? json['MasterE']
        : null;
    maxTemp = json['maxTemp'] != null && json['maxTemp'] != ''
        ? json['maxTemp']
        : null;
    minTemp = json['minTemp'] != null && json['minTemp'] != ''
        ? json['minTemp']
        : null;
    sendMode = json['SendMode'] == null
        ? null
        : SmsCallMode.fromHex(
            json['SendMode'],
          );
    serverIP = json['ServerIP'] != null && json['ServerIP'] != ''
        ? json['ServerIP']
        : null;
    deviceId = json['deviceId'] != null && json['deviceId'] != ''
        ? json['deviceId']
        : null;
    acclRange = json['AcclRange'] != null && json['AcclRange'] != ''
        ? json['AcclRange']
        : null;
    resetTime = json['ResetTime'] != null && json['ResetTime'] != ''
        ? json['ResetTime']
        : null;
    deviceInfoId = json['device_id'] != null && json['device_id'] != ''
        ? json['device_id']
        : null;
    timestamp = json['timestamp'] != null && json['timestamp'] != ''
        ? json['timestamp']
        : null;
    acclActive = json['AcclActive'] != null && json['AcclActive'] != ''
        ? json['AcclActive']
        : null;
    serverPort = json['ServerPort'] != null && json['ServerPort'] != ''
        ? json['ServerPort']
        : null;
    simCardMCC = json['SimCardMCC'] != null && json['SimCardMCC'] != ''
        ? json['SimCardMCC']
        : null;
    simCardMNC = json['SimCardMNC'] != null && json['SimCardMNC'] != ''
        ? json['SimCardMNC']
        : null;
    packetType = json['packetType'] != null && json['packetType'] != ''
        ? json['packetType']
        : null;
    speedRatio = json['speedRatio'] != null && json['speedRatio'] != ''
        ? json['speedRatio']
        : null;
    vehicleId = json['vehicle_id'] != null && json['vehicle_id'] != ''
        ? json['vehicle_id']
        : null;
    apnPassword = json['APNPassword'] != null && json['APNPassword'] != ''
        ? json['APNPassword']
        : null;
    apnUserName = json['APNUserName'] != null && json['APNUserName'] != ''
        ? json['APNUserName']
        : null;
    envPackTime = json['ENVPackTime'] != null && json['ENVPackTime'] != ''
        ? json['ENVPackTime']
        : null;
    intSendTime = json['IntSendTime'] != null && json['IntSendTime'] != ''
        ? json['IntSendTime']
        : null;
    smsCallMode = json['SMSCallMode'] == null
        ? null
        : SmsCallMode.fromHex(json['SMSCallMode']);
    maxHumidity = json['maxHumidity'] != null && json['maxHumidity'] != ''
        ? json['maxHumidity']
        : null;
    maxPressure = json['maxPressure'] != null && json['maxPressure'] != ''
        ? json['maxPressure']
        : null;
    minHumidity = json['minHumidity'] != null && json['minHumidity'] != ''
        ? json['minHumidity']
        : null;
    minPressure = json['minPressure'] != null && json['minPressure'] != ''
        ? json['minPressure']
        : null;
    autoPackTime = json['AutoPackTime'] != null && json['AutoPackTime'] != ''
        ? json['AutoPackTime']
        : null;
    gsmResetTime = json['GSMResetTime'] != null && json['GSMResetTime'] != ''
        ? json['GSMResetTime']
        : null;
    acclThreshold = json['AcclThreshold'] != null && json['AcclThreshold'] != ''
        ? json['AcclThreshold']
        : null;
    autoPackCount = json['AutoPackCount'] != null && json['AutoPackCount'] != ''
        ? json['AutoPackCount']
        : null;
    fuelThreshold = json['fuelThreshold'] != null && json['fuelThreshold'] != ''
        ? json['fuelThreshold']
        : null;
    acclInactiveTm =
        json['AcclInactiveTm'] != null && json['AcclInactiveTm'] != ''
            ? json['AcclInactiveTm']
            : null;
    speedThreshold =
        json['speedThreshold'] != null && json['speedThreshold'] != ''
            ? json['speedThreshold']
            : null;
    intSendDistance =
        json['IntSendDistance'] != null && json['IntSendDistance'] != ''
            ? json['IntSendDistance']
            : null;
    answerValidation =
        json['AnswerValidation'] != null && json['AnswerValidation'] != ''
            ? json['AnswerValidation']
            : null;
    recievedTimestamp =
        json['recievedTimestamp'] != null && json['recievedTimestamp'] != ''
            ? json['recievedTimestamp']
            : null;
    if (json['SOSNumbers'] != null) {
      final sosNumbers = <String>[];
      json['SOSNumbers'].forEach((v) {
        sosNumbers.add(v);
      });
      concoxSosNumbers = sosNumbers;
      concoxAlarm =
          json['alarm'] == null ? null : ConcoxAlarm.fromJson(json['alarm']);
      concoxCenterNumber = json['center'];
      concoxRelay = json['relay'] == null ? null : json['relay'] == 1;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['APNName'] = apnName;
    data['MasterA'] = masterA;
    data['MasterB'] = masterB;
    data['MasterC'] = masterC;
    data['MasterD'] = masterD;
    data['MasterE'] = masterE;
    data['maxTemp'] = maxTemp;
    data['minTemp'] = minTemp;
    data['SendMode'] = sendMode;
    data['ServerIP'] = serverIP;
    data['deviceId'] = deviceId;
    data['AcclRange'] = acclRange;
    data['ResetTime'] = resetTime;
    data['device_id'] = deviceId;
    data['timestamp'] = timestamp;
    data['AcclActive'] = acclActive;
    data['ServerPort'] = serverPort;
    data['SimCardMCC'] = simCardMCC;
    data['SimCardMNC'] = simCardMNC;
    data['packetType'] = packetType;
    data['speedRatio'] = speedRatio;
    data['vehicle_id'] = vehicleId;
    data['APNPassword'] = apnPassword;
    data['APNUserName'] = apnUserName;
    data['ENVPackTime'] = envPackTime;
    data['IntSendTime'] = intSendTime;
    data['SMSCallMode'] = smsCallMode == null ? null : smsCallMode!.toJson();
    data['maxHumidity'] = maxHumidity;
    data['maxPressure'] = maxPressure;
    data['minHumidity'] = minHumidity;
    data['minPressure'] = minPressure;
    data['AutoPackTime'] = autoPackTime;
    data['GSMResetTime'] = gsmResetTime;
    data['AcclThreshold'] = acclThreshold;
    data['AutoPackCount'] = autoPackCount;
    data['fuelThreshold'] = fuelThreshold;
    data['AcclInactiveTm'] = acclInactiveTm;
    data['speedThreshold'] = speedThreshold;
    data['IntSendDistance'] = intSendDistance;
    data['AnswerValidation'] = answerValidation;
    if (concoxSosNumbers != null) {
      data['SOSNumbers'] = concoxSosNumbers!;
    }
    data['alarm'] = concoxAlarm != null ? concoxAlarm!.toJson() : null;
    data['center'] = concoxCenterNumber;
    data['relay'] = concoxRelay ?? false ? 1 : 0;
    return data;
  }

  Info clone() => Info(
        id: id,
        apnName: apnName,
        masterA: masterA,
        masterB: masterB,
        masterC: masterC,
        masterD: masterD,
        masterE: masterE,
        maxTemp: maxTemp,
        minTemp: minTemp,
        sendMode: sendMode,
        serverIP: serverIP,
        deviceId: deviceId,
        acclRange: acclRange,
        resetTime: resetTime,
        deviceInfoId: deviceInfoId,
        timestamp: timestamp,
        acclActive: acclActive,
        serverPort: serverPort,
        simCardMCC: simCardMCC,
        simCardMNC: simCardMNC,
        packetType: packetType,
        speedRatio: speedRatio,
        vehicleId: vehicleId,
        apnPassword: apnPassword,
        apnUserName: apnUserName,
        envPackTime: envPackTime,
        intSendTime: intSendTime,
        smsCallMode: smsCallMode?.clone(),
        maxHumidity: maxHumidity,
        maxPressure: maxPressure,
        minHumidity: minHumidity,
        minPressure: minPressure,
        autoPackTime: autoPackTime,
        gsmResetTime: gsmResetTime,
        acclThreshold: acclThreshold,
        autoPackCount: autoPackCount,
        fuelThreshold: fuelThreshold,
        acclInactiveTm: acclInactiveTm,
        speedThreshold: speedThreshold,
        intSendDistance: intSendDistance,
        answerValidation: answerValidation,
        recievedTimestamp: recievedTimestamp,
        concoxSosNumbers: concoxSosNumbers,
        concoxAlarm: concoxAlarm,
        concoxCenterNumber: concoxCenterNumber,
        concoxRelay: concoxRelay,
      );

  List<num?> getCmds() => [
        speedThreshold ?? 0,
        fuelThreshold ?? 0,
        maxTemp ?? 0,
        minTemp ?? 0,
        maxHumidity ?? 0,
        minHumidity ?? 0,
        maxPressure ?? 0,
        minPressure ?? 0,
        autoPackTime ?? 0,
        envPackTime ?? 0,
        autoPackCount ?? 0,
        smsCallMode?.hex ?? 0,
        sendMode?.hex ?? 0,
        masterA ?? 9000000000,
        masterB ?? 9000000000,
        masterC ?? 9000000000,
        masterD ?? 9000000000,
        masterE ?? 9000000000,
        resetTime ?? 0,
        gsmResetTime ?? 0,
        acclActive ?? 0,
        acclRange ?? 0,
        acclThreshold ?? 0,
        acclInactiveTm ?? 0,
        null,
        null,
        null,
        null,
        null,
        intSendTime ?? 0,
        intSendDistance ?? 0,
        simCardMCC ?? 0,
        simCardMNC ?? 0,
      ];
}

class ConcoxAlarm {
  ConcoxAlarm({
    this.accAlarm,
    this.sosAlarm,
    this.powerAlarm,
    this.speedAlarm,
    this.movingAlarm,
    this.batteryAlarm,
    this.vibrationAlarm,
  });

  ConcoxAlarmInfo? accAlarm;
  ConcoxAlarmInfo? sosAlarm;
  ConcoxAlarmInfo? powerAlarm;
  ConcoxAlarmInfo? speedAlarm;
  ConcoxAlarmInfo? movingAlarm;
  ConcoxAlarmInfo? batteryAlarm;
  ConcoxAlarmInfo? vibrationAlarm;

  ConcoxAlarm.fromJson(Map<String, dynamic> json) {
    accAlarm = json['accAlarm'] != null
        ? ConcoxAlarmInfo.fromJson(json['accAlarm'])
        : null;
    sosAlarm = json['sosAlarm'] != null
        ? ConcoxAlarmInfo.fromJson(json['sosAlarm'])
        : null;
    powerAlarm = json['powerAlarm'] != null
        ? ConcoxAlarmInfo.fromJson(json['powerAlarm'])
        : null;
    speedAlarm = json['speedAlarm'] != null
        ? ConcoxAlarmInfo.fromJson(json['speedAlarm'])
        : null;
    movingAlarm = json['movingAlarm'] != null
        ? ConcoxAlarmInfo.fromJson(json['movingAlarm'])
        : null;
    batteryAlarm = json['batteryAlarm'] != null
        ? ConcoxAlarmInfo.fromJson(json['batteryAlarm'])
        : null;
    vibrationAlarm = json['vibrationAlarm'] != null
        ? ConcoxAlarmInfo.fromJson(json['vibrationAlarm'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accAlarm'] = accAlarm != null ? accAlarm!.toJson() : null;
    data['sosAlarm'] = sosAlarm != null ? sosAlarm!.toJson() : null;
    data['powerAlarm'] = powerAlarm != null ? powerAlarm!.toJson() : null;
    data['speedAlarm'] = speedAlarm != null ? speedAlarm!.toJson() : null;
    data['movingAlarm'] = movingAlarm != null ? movingAlarm!.toJson() : null;
    data['batteryAlarm'] = batteryAlarm != null ? batteryAlarm!.toJson() : null;
    data['vibrationAlarm'] =
        vibrationAlarm != null ? vibrationAlarm!.toJson() : null;
    return data;
  }
}

class ConcoxAlarmInfo {
  ConcoxAlarmInfo({
    this.state,
    this.alarmType,
    this.detectionTime,
    this.t1,
    this.t2,
    this.speedLimit,
    this.radius,
  });

  bool? state;
  CarSettingConcoxAlarmType? alarmType;
  num? detectionTime;
  num? t1;
  num? t2;
  num? speedLimit;
  num? radius;

  ConcoxAlarmInfo.fromJson(Map<String, dynamic> json) {
    state = json['state'] != null
        ? json['state'].toString().trim().toLowerCase() == 'on'
        : null;
    alarmType = json['alarmType'] != null
        ? json['alarmType'] < 3
            ? CarSettingConcoxAlarmType.values
                .elementAt(int.parse(json['alarmType'].toString()))
            : null
        : null;
    detectionTime = json['detecionTime'];
    t1 = json['T1'];
    t2 = json['T2'];
    speedLimit = json['speedLimit'];
    radius = json['radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['alarmType'] = alarmType;
    data['detecionTime'] = detectionTime;
    data['T1'] = t1;
    data['T2'] = t2;
    data['speedLimit'] = speedLimit;
    data['radius'] = radius;
    return data;
  }
}

class Vehicle {
  num? accountId;
  num? deviceId;
  String? customerId;
  String? contractId;
  Identification? identification;
  Classification? classification;
  Classification? specification;
  Classification? fuelinfo;
  Classification? lifecycledetails;
  Classification? engineandtransmission;
  Classification? wheelsandtires;
  RxBool? bookmark;
  String? state;
  Mileage? mileage;
  num? odometer;
  String? temporaryLink;
  String? temporaryLinkStatus;
  String? workedHour;
  Rx<Setting>? setting;
  String? notesIds;
  String? createtimestamp;
  Rx<Appsetting>? appsetting;
  num? id;
  List<String>? notifications;

  Vehicle({
    this.accountId,
    this.deviceId,
    this.customerId,
    this.contractId,
    this.identification,
    this.classification,
    this.specification,
    this.fuelinfo,
    this.lifecycledetails,
    this.engineandtransmission,
    this.wheelsandtires,
    this.bookmark,
    this.state,
    this.mileage,
    this.odometer,
    this.temporaryLink,
    this.temporaryLinkStatus,
    this.workedHour,
    this.setting,
    this.notesIds,
    this.createtimestamp,
    this.appsetting,
    this.id,
    this.notifications,
  });

  Vehicle.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    deviceId = json['device_id'];
    customerId = json['customer_id'];
    contractId = json['contract_id'];
    identification = json['identification'] != null
        ? Identification.fromJson(json['identification'])
        : null;
    classification = json['classification'] != null
        ? Classification.fromJson(json['classification'])
        : null;
    // specification = json['specification'] != null
    //     ? Classification.fromJson(json['specification'])
    //     : null;
    // fuelinfo = json['fuelinfo'] != null
    //     ? Classification.fromJson(json['fuelinfo'])
    //     : null;
    // lifecycledetails = json['lifecycledetails'] != null
    //     ? Classification.fromJson(json['lifecycledetails'])
    //     : null;
    // engineandtransmission = json['engineandtransmission'] != null
    //     ? Classification.fromJson(json['engineandtransmission'])
    //     : null;
    // wheelsandtires = json['wheelsandtires'] != null
    //     ? Classification.fromJson(json['wheelsandtires'])
    //     : null;
    bookmark = RxBool(json['bookmark'] ?? false);
    state = json['state'];
    mileage =
        json['mileage'] != null ? Mileage.fromJson(json['mileage']) : null;
    odometer = json['odometer'];
    temporaryLink = json['temporary_link'];
    temporaryLinkStatus = json['temporary_link_status'];
    workedHour = json['worked_hour'];
    setting =
        json['setting'] != null ? Rx(Setting.fromJson(json['setting'])) : null;
    notesIds = json['notes_ids'];
    createtimestamp = json['createtimestamp'];
    appsetting = json['appsetting'] != null
        ? Rx(Appsetting.fromJson(json['appsetting']))
        : null;
    id = json['_id'];
    if (json['notifications'] != null) {
      final notifications = <String>[];
      json['notifications'].forEach((v) {
        notifications.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    data['device_id'] = deviceId;
    data['customer_id'] = customerId;
    data['contract_id'] = contractId;
    if (identification != null) {
      data['identification'] = identification!.toJson();
    }
    if (classification != null) {
      data['classification'] = classification!.toJson();
    }
    if (specification != null) {
      data['specification'] = specification!.toJson();
    }
    if (fuelinfo != null) {
      data['fuelinfo'] = fuelinfo!.toJson();
    }
    if (lifecycledetails != null) {
      data['lifecycledetails'] = lifecycledetails!.toJson();
    }
    if (engineandtransmission != null) {
      data['engineandtransmission'] = engineandtransmission!.toJson();
    }
    if (wheelsandtires != null) {
      data['wheelsandtires'] = wheelsandtires!.toJson();
    }
    data['bookmark'] = bookmark!.value;
    data['state'] = state;
    if (mileage != null) {
      data['mileage'] = mileage!.toJson();
    }
    data['odometer'] = odometer;
    data['temporary_link'] = temporaryLink;
    data['temporary_link_status'] = temporaryLinkStatus;
    data['worked_hour'] = workedHour;
    if (setting != null) {
      data['setting'] = setting!.toJson();
    }
    data['notes_ids'] = notesIds;
    data['createtimestamp'] = createtimestamp;
    if (appsetting != null) {
      data['appsetting'] = appsetting!.toJson();
    }
    data['_id'] = id;
    if (notifications != null) {
      data['notifications'] = notifications!;
    }
    return data;
  }
}

class Identification {
  String? vin;
  String? msrp;
  String? made;
  String? name;
  String? trim;
  String? type;
  String? color;
  String? model;
  Photo? photo;
  String? motor;
  Plate? plate;
  String? system;
  String? chassis;
  String? bodyType;
  String? year;
  String? carBarcode;
  String? propertyCode;
  String? registrationState;

  Identification({
    this.vin,
    this.msrp,
    this.made,
    this.name,
    this.trim,
    this.type,
    this.color,
    this.model,
    this.photo,
    this.motor,
    this.plate,
    this.system,
    this.chassis,
    this.bodyType,
    this.year,
    this.carBarcode,
    this.propertyCode,
    this.registrationState,
  });

  Identification.fromJson(Map<String, dynamic> json) {
    vin = json['vin'] != null ? json["vin"].toString() : null;
    msrp = json['MSRP'] != null ? json["MSRP"].toString() : null;
    made = json['made'] != null ? json["made"].toString() : null;
    name = json['name'] != null ? json["name"].toString() : null;
    trim = json['trim'] != null ? json["trim"].toString() : null;
    type = json['type'] != null ? json["type"].toString() : null;
    color = json['color'] != null ? json["color"].toString() : null;
    model = json['model'] != null ? json["model"].toString() : null;
    photo = json['photo'] != null ? Photo.fromJson(json['photo']) : null;
    motor = json['motor'] != null ? json["motor"].toString() : null;
    plate = json['plate'] != null ? Plate.fromJson(json['plate']) : null;
    system = json['system'] != null ? json["system"].toString() : null;
    chassis = json['chassis'] != null ? json["chassis"].toString() : null;
    bodyType = json['bodyType'] != null ? json["bodyType"].toString() : null;
    year = json['year'] != null ? json["year"].toString() : null;
    carBarcode =
        json['carBarcode'] != null ? json["carBarcode"].toString() : null;
    propertyCode =
        json['propertyCode'] != null ? json["propertyCode"].toString() : null;
    registrationState = json['registrationState'] != null
        ? json["registrationState"].toString()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vin'] = vin;
    data['MSRP'] = msrp;
    data['made'] = made;
    data['name'] = name;
    data['trim'] = trim;
    data['type'] = type;
    data['color'] = color;
    data['model'] = model;
    if (photo != null) {
      data['photo'] = photo!.toJson();
    }
    data['motor'] = motor;
    if (plate != null) {
      data['plate'] = plate!.toJson();
    }
    data['system'] = system;
    data['chassis'] = chassis;
    data['bodyType'] = bodyType;
    data['year'] = year;
    data['carBarcode'] = carBarcode;
    data['propertyCode'] = propertyCode;
    data['registrationState'] = registrationState;
    return data;
  }
}

class Photo {
  String? mim;
  String? name;
  String? originalName;

  Photo({
    required this.mim,
    required this.name,
    required this.originalName,
  });

  Photo.fromJson(Map<String, dynamic> json) {
    mim = json['mim'];
    name = json['name'];
    originalName = json['originalName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mim'] = mim;
    data['name'] = name;
    data['originalName'] = originalName;
    return data;
  }
}

class Plate {
  String? first;
  String? second;
  String? third;
  String? fourth;
  String? fullPlate;

  Plate({
    this.first,
    this.second,
    this.third,
    this.fourth,
    this.fullPlate,
  });

  Plate.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    second = json['second'];
    third = json['third'];
    fourth = json['fourth'];
    fullPlate = json['fullPlate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['second'] = second;
    data['third'] = third;
    data['fourth'] = fourth;
    data['fullPlate'] = fullPlate;
    return data;
  }
}

class Classification {
  String? group;
  String? status;
  String? driverId;
  String? ownerShip;
  num? driverRoleId;
  Classification({
    this.group,
    this.status,
    this.driverId,
    this.ownerShip,
    this.driverRoleId,
  });

  Classification.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    status = json['status'];
    driverId = json['driver_id'];
    ownerShip = json['ownership'];
    driverRoleId = json['driver_roleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group'] = group;
    data['status'] = status;
    data['driver_id'] = driverId;
    data['ownership'] = ownerShip;
    data['driver_roleId'] = driverRoleId;
    return data;
  }
}

class Setting {
  SettingInfo? acc;
  SettingInfo? job;
  SettingInfo? net;
  SettingInfo? sos;
  SettingInfo? bill;
  SettingInfo? form;
  SettingInfo? zone;
  SettingInfo? towing;
  SettingInfo? lastEnv;
  SettingInfo? mission;
  SettingInfo? humidity;
  SettingInfo? movement;
  SettingInfo? workflow;
  SettingInfo? fuelLevel;
  SettingInfo? lastTrack;
  SettingInfo? mainPower;
  SettingInfo? overSpeed;
  SettingInfo? simCharge;
  SettingInfo? acclstatus;
  SettingInfo? lastPacket;
  SettingInfo? temperature;
  SettingInfo? batteryCharge;
  SettingInfo? securityAlarm;
  SettingInfo? accWiringState;
  SettingInfo? fuelRelayState;
  SettingInfo? gpsAntennaState;
  SettingInfo? powerRelayState;
  SettingInfo? serviceReminder;
  SettingInfo? securityCommandState;
  SettingInfo? gpsAntennaShortCircuit;

  Setting({
    this.acc,
    this.job,
    this.net,
    this.sos,
    this.bill,
    this.form,
    this.zone,
    this.towing,
    this.lastEnv,
    this.mission,
    this.humidity,
    this.movement,
    this.workflow,
    this.fuelLevel,
    this.lastTrack,
    this.mainPower,
    this.overSpeed,
    this.simCharge,
    this.acclstatus,
    this.lastPacket,
    this.temperature,
    this.batteryCharge,
    this.securityAlarm,
    this.accWiringState,
    this.fuelRelayState,
    this.gpsAntennaState,
    this.powerRelayState,
    this.serviceReminder,
    this.securityCommandState,
    this.gpsAntennaShortCircuit,
  });

  Setting.fromJson(Map<String, dynamic> json) {
    acc = json['ACC'] != null ? SettingInfo.fromJson(json['ACC']) : null;
    job = json['job'] != null ? SettingInfo.fromJson(json['job']) : null;
    net = json['net'] != null ? SettingInfo.fromJson(json['net']) : null;
    sos = json['sos'] != null ? SettingInfo.fromJson(json['sos']) : null;
    bill = json['bill'] != null ? SettingInfo.fromJson(json['bill']) : null;
    form = json['form'] != null ? SettingInfo.fromJson(json['form']) : null;
    zone = json['zone'] != null ? SettingInfo.fromJson(json['zone']) : null;
    towing =
        json['towing'] != null ? SettingInfo.fromJson(json['towing']) : null;
    lastEnv =
        json['lastEnv'] != null ? SettingInfo.fromJson(json['lastEnv']) : null;
    mission =
        json['mission'] != null ? SettingInfo.fromJson(json['mission']) : null;
    humidity = json['humidity'] != null
        ? SettingInfo.fromJson(json['humidity'])
        : null;
    movement = json['movement'] != null
        ? SettingInfo.fromJson(json['movement'])
        : null;
    workflow = json['workflow'] != null
        ? SettingInfo.fromJson(json['workflow'])
        : null;
    fuelLevel = json['fuelLevel'] != null
        ? SettingInfo.fromJson(json['fuelLevel'])
        : null;
    lastTrack = json['lastTrack'] != null
        ? SettingInfo.fromJson(json['lastTrack'])
        : null;
    mainPower = json['mainPower'] != null
        ? SettingInfo.fromJson(json['mainPower'])
        : null;
    overSpeed = json['overSpeed'] != null
        ? SettingInfo.fromJson(json['overSpeed'])
        : null;
    simCharge = json['simCharge'] != null
        ? SettingInfo.fromJson(json['simCharge'])
        : null;
    acclstatus = json['ACCLstatus'] != null
        ? SettingInfo.fromJson(json['ACCLstatus'])
        : null;
    lastPacket = json['lastPacket'] != null
        ? SettingInfo.fromJson(json['lastPacket'])
        : null;
    temperature = json['temperature'] != null
        ? SettingInfo.fromJson(json['temperature'])
        : null;
    batteryCharge = json['batteryCharge'] != null
        ? SettingInfo.fromJson(json['batteryCharge'])
        : null;
    securityAlarm = json['securityAlarm'] != null
        ? SettingInfo.fromJson(json['securityAlarm'])
        : null;
    accWiringState = json['accWiringState'] != null
        ? SettingInfo.fromJson(json['accWiringState'])
        : null;
    fuelRelayState = json['fuelRelayState'] != null
        ? SettingInfo.fromJson(json['fuelRelayState'])
        : null;
    gpsAntennaState = json['gpsAntennaState'] != null
        ? SettingInfo.fromJson(json['gpsAntennaState'])
        : null;
    powerRelayState = json['powerRelayState'] != null
        ? SettingInfo.fromJson(json['powerRelayState'])
        : null;
    serviceReminder = json['serviceReminder'] != null
        ? SettingInfo.fromJson(json['serviceReminder'])
        : null;
    securityCommandState = json['securityCommandState'] != null
        ? SettingInfo.fromJson(json['securityCommandState'])
        : null;
    gpsAntennaShortCircuit = json['gpsAntennaShortCircuit'] != null
        ? SettingInfo.fromJson(json['gpsAntennaShortCircuit'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (acc != null) {
      data['ACC'] = acc!.toJson();
    }
    if (job != null) {
      data['job'] = job!.toJson();
    }
    if (net != null) {
      data['net'] = net!.toJson();
    }
    if (sos != null) {
      data['sos'] = sos!.toJson();
    }
    if (bill != null) {
      data['bill'] = bill!.toJson();
    }
    if (form != null) {
      data['form'] = form!.toJson();
    }
    if (zone != null) {
      data['zone'] = zone!.toJson();
    }
    if (towing != null) {
      data['towing'] = towing!.toJson();
    }
    if (lastEnv != null) {
      data['lastEnv'] = lastEnv!.toJson();
    }
    if (mission != null) {
      data['mission'] = mission!.toJson();
    }
    if (humidity != null) {
      data['humidity'] = humidity!.toJson();
    }
    if (movement != null) {
      data['movement'] = movement!.toJson();
    }
    if (workflow != null) {
      data['workflow'] = workflow!.toJson();
    }
    if (fuelLevel != null) {
      data['fuelLevel'] = fuelLevel!.toJson();
    }
    if (lastTrack != null) {
      data['lastTrack'] = lastTrack!.toJson();
    }
    if (mainPower != null) {
      data['mainPower'] = mainPower!.toJson();
    }
    if (overSpeed != null) {
      data['overSpeed'] = overSpeed!.toJson();
    }
    if (simCharge != null) {
      data['simCharge'] = simCharge!.toJson();
    }
    if (acclstatus != null) {
      data['ACCLstatus'] = acclstatus!.toJson();
    }
    if (lastPacket != null) {
      data['lastPacket'] = lastPacket!.toJson();
    }
    if (temperature != null) {
      data['temperature'] = temperature!.toJson();
    }
    if (batteryCharge != null) {
      data['batteryCharge'] = batteryCharge!.toJson();
    }
    if (securityAlarm != null) {
      data['securityAlarm'] = securityAlarm!.toJson();
    }
    if (accWiringState != null) {
      data['accWiringState'] = accWiringState!.toJson();
    }
    if (fuelRelayState != null) {
      data['fuelRelayState'] = fuelRelayState!.toJson();
    }
    if (gpsAntennaState != null) {
      data['gpsAntennaState'] = gpsAntennaState!.toJson();
    }
    if (powerRelayState != null) {
      data['powerRelayState'] = powerRelayState!.toJson();
    }
    if (serviceReminder != null) {
      data['serviceReminder'] = serviceReminder!.toJson();
    }
    if (securityCommandState != null) {
      data['securityCommandState'] = securityCommandState!.toJson();
    }
    if (gpsAntennaShortCircuit != null) {
      data['gpsAntennaShortCircuit'] = gpsAntennaShortCircuit!.toJson();
    }
    return {
      'vehicle': {'setting': data}
    };
  }
}

class SettingInfo {
  num? max;
  num? min;
  String? time;
  num? flag;
  bool? hidden;
  bool? alarmAfter;
  num? earlyWarning;
  num? earlyWarningOdometer;
  num? value;
  List<String>? sendType;
  List<num>? receivers;

  SettingInfo({
    this.max,
    this.min,
    this.time,
    this.flag,
    this.hidden,
    this.alarmAfter,
    this.earlyWarning,
    this.earlyWarningOdometer,
    this.value,
    this.sendType,
    this.receivers,
  });

  SettingInfo.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    min = json['min'];
    time = json["time"] == null ? null : json['time'].toString();
    flag = json['flag'];
    hidden = json['hidden'];
    alarmAfter = json['alarmAfter'];
    earlyWarning = json['earlyWarning'];
    earlyWarningOdometer = json['earlyWarningOdometer'];
    value = json['value'];
    if (json['sendType'] != null) {
      sendType = <String>[];
      json['sendType'].forEach((v) {
        sendType!.add(v);
      });
    }
    if (json['receivers'] != null) {
      receivers = <num>[];
      json['receivers'].forEach((v) {
        receivers!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (max != null) {
      data['max'] = max;
    }
    if (min != null) {
      data['min'] = min;
    }
    if (time != null) {
      data['time'] = time;
    }
    if (flag != null) {
      data['flag'] = flag;
    }
    if (hidden != null) {
      data['hidden'] = hidden;
    }
    if (alarmAfter != null) {
      data['alarmAfter'] = alarmAfter;
    }
    if (earlyWarning != null) {
      data['earlyWarning'] = earlyWarning;
    }
    if (earlyWarningOdometer != null) {
      data['earlyWarningOdometer'] = earlyWarningOdometer;
    }
    if (value != null) {
      data['value'] = value;
    }
    if (sendType != null) {
      data['sendType'] = sendType;
    }
    if (receivers != null) {
      data['receivers'] = receivers;
    }
    return data;
  }
}

class Appsetting {
  AlarmInfo? acc;
  Relay? relay;
  AlarmInfo? movement;
  RelayType? mapScreenType;
  RelayType? vehicleScreenType;

  Appsetting({
    this.acc,
    this.relay,
    this.movement,
    this.mapScreenType,
    this.vehicleScreenType,
  });

  Appsetting.fromJson(Map<String, dynamic> json) {
    acc = json['ACC'] != null ? AlarmInfo.fromJson(json['ACC']) : null;
    relay = json['relay'] != null ? Relay.fromJson(json['relay']) : null;
    movement =
        json['movement'] != null ? AlarmInfo.fromJson(json['movement']) : null;
    if (relay != null && (relay!.mapScreen ?? false)) {
      if ((relay!.type ?? 'power') == 'power') {
        mapScreenType = RelayType.power;
      } else if ((relay!.type ?? 'fuel') == 'fuel') {
        mapScreenType = RelayType.fuel;
      } else {
        mapScreenType = RelayType.power;
      }
    } else if (acc != null && (acc!.mapScreen ?? false)) {
      mapScreenType = RelayType.powerAlarm;
    } else if (acc != null && (movement!.mapScreen ?? false)) {
      mapScreenType = RelayType.movementAlarm;
    }
    if (acc != null && (acc!.vehicle ?? false)) {
      vehicleScreenType = RelayType.powerAlarm;
    } else if (movement != null && (movement!.vehicle ?? false)) {
      vehicleScreenType = RelayType.movementAlarm;
    } else {
      if (relay != null) {
        if ((relay!.type ?? 'power') == 'power') {
          vehicleScreenType = RelayType.power;
        } else if ((relay!.type ?? 'fuel') == 'fuel') {
          vehicleScreenType = RelayType.fuel;
        } else {
          vehicleScreenType = RelayType.power;
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (acc != null) {
      data['ACC'] = acc!.toJson();
    }
    if (relay != null) {
      data['relay'] = relay!.toJson();
    }
    if (movement != null) {
      data['movement'] = movement!.toJson();
    }
    data['map_screen_type'] = mapScreenType;
    return data;
  }
}

class Relay {
  String? type;
  bool? mapScreen;

  Relay({
    this.type,
    this.mapScreen,
  });

  Relay.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    mapScreen = json['mapScreen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['mapScreen'] = mapScreen;
    return data;
  }
}

class AlarmInfo {
  bool? vehicle;
  bool? mapScreen;

  AlarmInfo({
    this.vehicle,
    this.mapScreen,
  });

  AlarmInfo.fromJson(Map<String, dynamic> json) {
    vehicle = json['vehicle'];
    mapScreen = json['mapScreen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicle'] = vehicle;
    data['mapScreen'] = mapScreen;
    return data;
  }
}

class LastDeviceStatus {
  String? id;
  num? deviceIntId;
  String? deviceId;
  Rx<bool>? online;
  num? vehicleId;
  num? linkTimestamp;
  Rx<Track>? track;
  num? lastUnValidENV;
  num? lastNoOfflineTimestamp;
  num? lastAccOff;
  num? lastAccOn;
  Rx<Track>? lastZeroTrack;
  num? timestampZero;
  Mileage? mileage;
  Odometer? odometer;
  Rx<Info>? setting;
  Rx<Security>? security;

  LastDeviceStatus({
    this.id,
    this.deviceIntId,
    this.deviceId,
    this.online,
    this.vehicleId,
    this.linkTimestamp,
    this.track,
    this.lastUnValidENV,
    this.lastNoOfflineTimestamp,
    this.lastZeroTrack,
    this.lastAccOff,
    this.lastAccOn,
    this.timestampZero,
    this.mileage,
    this.odometer,
    this.setting,
    this.security,
  });

  LastDeviceStatus.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    deviceIntId = json['device_id'];
    deviceId = json['deviceId'];
    online = json['online'] != null ? Rx(json['online']) : null;
    vehicleId = json['vehicle_id'];
    linkTimestamp = json['linkTimestamp'];
    track = Rx(json['track'] != null ? Track.fromJson(json['track']) : Track());
    lastUnValidENV = json['lastUnValidENV'];
    lastNoOfflineTimestamp = json['lastNoOfflineTimestamp'];
    lastZeroTrack = Rx(json['lastZeroTrack'] != null
        ? Track.fromJson(json['lastZeroTrack'])
        : Track());
    lastAccOff = json['lastAccOff'];
    lastAccOn = json['lastAccOn'];
    timestampZero = json['timestampZero'];
    mileage =
        json['mileage'] != null ? Mileage.fromJson(json['mileage']) : null;
    odometer =
        json['odometer'] != null ? Odometer.fromJson(json['odometer']) : null;
    setting =
        json['setting'] != null ? Rx(Info.fromJson(json['setting'])) : null;
    security = json['security'] != null
        ? Rx(Security.fromJson(json['security']))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['device_id'] = deviceIntId;
    data['deviceId'] = deviceId;
    data['online'] = online?.value;
    data['vehicle_id'] = vehicleId;
    data['linkTimestamp'] = linkTimestamp;
    if (track != null) {
      data['track'] = track!.toJson();
    }
    data['lastUnValidENV'] = lastUnValidENV;
    data['lastNoOfflineTimestamp'] = lastNoOfflineTimestamp;
    if (lastZeroTrack != null) {
      data['lastZeroTrack'] = lastZeroTrack!.toJson();
    }
    data['timestampZero'] = timestampZero;
    if (mileage != null) {
      data['mileage'] = mileage!.toJson();
    }
    if (odometer != null) {
      data['odometer'] = odometer!.toJson();
    }
    if (setting != null) {
      data['setting'] = setting!.toJson();
    }
    if (security != null) {
      data['setting'] = security!.toJson();
    }
    return data;
  }
}

class Security {
  String? id;
  num? timestamp;
  Loc? loc;
  num? speed;
  num? state;
  SecurityInput? input;
  num? typeSec;
  bool? ok;
  num? device_id;
  String? deviceId;
  num? vehicle_id;
  num? recievedTimestamp;
  String? secTypeString;

  Security.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    loc = json['loc'] != null ? Loc.fromJson(json['loc']) : null;
    speed = json['speed'];
    state = json['state'];
    input = json['input'] != null ? SecurityInput.fromHex(json['input']) : null;
    typeSec = json['typeSec'];
    ok = json['ok'];
    device_id = json['device_id'];
    deviceId = json['deviceId'];
    vehicle_id = json['vehicle_id'];
    recievedTimestamp = json['recievedTimestamp'];
    secTypeString = _getSecTypeString();
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    if (loc != null) {
      data['loc'] = loc!.toJson();
    }
    data['speed'] = speed;
    data['state'] = state;
    if (input != null) {
      data['input'] = input!.toJson();
    }
    data['typeSec'] = typeSec;
    data['ok'] = ok;
    data['device_id'] = device_id;
    data['deviceId'] = deviceId;
    data['vehicle_id'] = vehicle_id;
    data['secTypeString'] = secTypeString;
    data['recievedTimestamp'] = recievedTimestamp;
    data['_id'] = id;
    return data;
  }

  String _getSecTypeString() {
    switch (state) {
      case 0:
        return 'باز کردن قفل در';
      case 1:
        return 'قفل بیصدا';
      case 2:
        return 'قفل با صدا';
      case 3:
        return 'وصل کردن جریان برق';
      case 4:
        return 'هشدار';
      case 5:
        return 'آژیر';
      case 6:
        return 'حالت کارواش';
      default:
        return '';
    }
  }
}

class Track {
  num? timestamp;
  num? packetType;
  GPS? gps;
  GSM? gsm;
  Cell? cell;
  StatReg? statReg;
  num? fuel;
  num? batCharge;
  num? recievedTimestamp;
  bool? on;
  num? vehicleId;
  String? deviceId;
  num? deviceIntId;
  String? id;

  Track({
    this.timestamp,
    this.packetType,
    this.gps,
    this.gsm,
    this.cell,
    this.statReg,
    this.fuel,
    this.batCharge,
    this.recievedTimestamp,
    this.on,
    this.vehicleId,
    this.deviceIntId,
    this.deviceId,
    this.id,
  });

  Track.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    packetType = json['packetType'];
    gps = json['GPS'] != null ? GPS.fromJson(json['GPS']) : null;
    gsm = json['GSM'] != null ? GSM.fromJson(json['GSM']) : null;
    cell = json['cell'] != null ? Cell.fromJson(json['cell']) : null;
    statReg = json['statReg'] != null ? StatReg.fromHex(json['statReg']) : null;
    fuel = json['fuel'];
    batCharge = json['batCharge'];
    recievedTimestamp = json['recievedTimestamp'];
    on = json['on'];
    vehicleId = json['vehicle_id'];
    deviceIntId = json['device_id'];
    deviceId = json['deviceId'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['packetType'] = packetType;
    if (gps != null) {
      data['GPS'] = gps!.toJson();
    }
    if (gsm != null) {
      data['GSM'] = gsm!.toJson();
    }
    if (cell != null) {
      data['cell'] = cell!.toJson();
    }
    if (statReg != null) {
      data['statReg'] = statReg!.toJson();
    }
    data['fuel'] = fuel;
    data['batCharge'] = batCharge;
    data['recievedTimestamp'] = recievedTimestamp;
    data['on'] = on;
    data['device_id'] = deviceIntId;
    data['vehicle_id'] = vehicleId;
    data['deviceId'] = deviceId;
    data['_id'] = id;
    return data;
  }
}

class SecurityInput {
  bool? doorState;
  bool? trunkState;
  bool? hoodState;
  bool? ultraFlag;
  bool? shockFlag;
  bool? childLock;
  bool? flasherAccOn;
  bool? autoLock;
  bool? shock;
  bool? ultra;
  bool? optionKey;
  bool? exitAlarmEg;
  bool? lockState;

  SecurityInput({
    this.doorState,
    this.trunkState,
    this.hoodState,
    this.ultraFlag,
    this.shockFlag,
    this.childLock,
    this.flasherAccOn,
    this.autoLock,
    this.shock,
    this.ultra,
    this.optionKey,
    this.exitAlarmEg,
    this.lockState,
  });

  factory SecurityInput.fromHex(num hex) {
    bool? doorState;
    bool? trunkState;
    bool? hoodState;
    bool? ultraFlag;
    bool? shockFlag;
    bool? childLock;
    bool? flasherAccOn;
    bool? autoLock;
    bool? shock;
    bool? ultra;
    bool? optionKey;
    bool? exitAlarmEg;
    bool? lockState;
    List<String> temp = AppUtil.getBinList(hex);
    doorState = AppUtil.getBool(temp.isNotEmpty ? temp[0] : '0');
    trunkState = AppUtil.getBool(temp.length > 1 ? temp[1] : '0');
    hoodState = AppUtil.getBool(temp.length > 2 ? temp[2] : '0');
    ultraFlag = AppUtil.getBool(temp.length > 3 ? temp[3] : '0');
    shockFlag = AppUtil.getBool(temp.length > 4 ? temp[4] : '0');
    childLock = AppUtil.getBool(temp.length > 5 ? temp[5] : '0');
    flasherAccOn = AppUtil.getBool(temp.length > 6 ? temp[6] : '0');
    autoLock = AppUtil.getBool(temp.length > 7 ? temp[7] : '0');
    shock = AppUtil.getBool(temp.length > 8 ? temp[8] : '0');
    ultra = AppUtil.getBool(temp.length > 9 ? temp[9] : '0');
    optionKey = AppUtil.getBool(temp.length > 10 ? temp[10] : '0');
    exitAlarmEg = AppUtil.getBool(temp.length > 11 ? temp[11] : '0');
    lockState = AppUtil.getBool(temp.length > 12 ? temp[12] : '0');

    return SecurityInput(
      doorState: doorState,
      trunkState: trunkState,
      hoodState: hoodState,
      ultraFlag: ultraFlag,
      shockFlag: shockFlag,
      childLock: childLock,
      flasherAccOn: flasherAccOn,
      autoLock: autoLock,
      shock: shock,
      ultra: ultra,
      optionKey: optionKey,
      exitAlarmEg: exitAlarmEg,
      lockState: lockState,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doorState'] = doorState;
    data['trunkState'] = trunkState;
    data['hoodState'] = hoodState;
    data['ultraFlag'] = ultraFlag;
    data['shockFlag'] = shockFlag;
    data['childLock'] = childLock;
    data['flasherAccOn'] = flasherAccOn;
    data['autoLock'] = autoLock;
    data['shock'] = shock;
    data['ultra'] = ultra;
    data['optionKey'] = optionKey;
    data['exitAlarmEg'] = exitAlarmEg;
    data['lockState'] = lockState;
    return data;
  }
}

class StatReg {
  num? hex;
  bool? accOn;
  bool? accConnected;
  bool? powerRelayOn;
  bool? fuelRelayOn;
  bool? hasSecurity;
  bool? movementAlarm;

  StatReg({
    this.hex,
    this.accOn,
    this.accConnected,
    this.powerRelayOn,
    this.fuelRelayOn,
    this.hasSecurity,
    this.movementAlarm,
  });

  factory StatReg.fromHex(num hex) {
    bool? accOn;
    bool? accConnected;
    bool? powerRelayOn;
    bool? fuelRelayOn;
    bool? hasSecurity;
    bool? movementAlarm;
    List<String> temp = AppUtil.getBinList(hex);
    accOn = AppUtil.getBool(temp.length > 6 ? temp[6] : '0');
    hasSecurity = AppUtil.getBool(temp.length > 10 ? temp[10] : '0');
    accConnected = AppUtil.getBool(temp.length > 11 ? temp[11] : '1', true);
    powerRelayOn = AppUtil.getBool(temp.length > 12 ? temp[12] : '0', true);
    fuelRelayOn = AppUtil.getBool(temp.length > 27 ? temp[27] : '0', true);
    movementAlarm = AppUtil.getBool(temp.length > 26 ? temp[26] : '0');

    return StatReg(
      hex: hex,
      accOn: accOn,
      accConnected: accConnected,
      powerRelayOn: powerRelayOn,
      fuelRelayOn: fuelRelayOn,
      hasSecurity: hasSecurity,
      movementAlarm: movementAlarm,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accOn'] = accOn;
    data['accConnected'] = accConnected;
    data['powerRelayOn'] = powerRelayOn;
    data['fuelRelayOn'] = fuelRelayOn;
    data['hasSecurity'] = hasSecurity;
    data['movementAlarm'] = movementAlarm;
    return data;
  }
}

class SmsCallMode {
  num? hex;
  bool? speedCallAlarm;
  bool? speedSmsAlarm;
  bool? sosCallAlarm;
  bool? sosSmsAlarm;
  bool? securityChangeCallAlarm;
  bool? securityChangeSmsAlarm;
  bool? securityWarningsSmsAlarm;
  bool? mainPowerCallAlarm;
  bool? mainPowerSmsAlarm;
  bool? carOnCallAlarm;
  bool? carOnSmsAlarm;
  bool? accCutCallAlarm;
  bool? accCutSmsAlarm;
  bool? movementCallAlarm;
  bool? movementSmsAlarm;
  bool? relayCutOff;
  bool? spareCutOff;
  bool? powerAlarm;
  bool? movementAlarm;

  SmsCallMode({
    this.hex,
    this.speedCallAlarm,
    this.speedSmsAlarm,
    this.sosCallAlarm,
    this.sosSmsAlarm,
    this.securityChangeCallAlarm,
    this.securityChangeSmsAlarm,
    this.securityWarningsSmsAlarm,
    this.mainPowerCallAlarm,
    this.mainPowerSmsAlarm,
    this.carOnCallAlarm,
    this.carOnSmsAlarm,
    this.accCutCallAlarm,
    this.accCutSmsAlarm,
    this.movementCallAlarm,
    this.movementSmsAlarm,
    this.relayCutOff,
    this.spareCutOff,
    this.powerAlarm,
    this.movementAlarm,
  });

  factory SmsCallMode.fromHex(num hex) {
    bool? speedCallAlarm;
    bool? speedSmsAlarm;
    bool? sosCallAlarm;
    bool? sosSmsAlarm;
    bool? securityChangeCallAlarm;
    bool? securityChangeSmsAlarm;
    bool? securityWarningsSmsAlarm;
    bool? mainPowerCallAlarm;
    bool? mainPowerSmsAlarm;
    bool? carOnCallAlarm;
    bool? carOnSmsAlarm;
    bool? accCutCallAlarm;
    bool? accCutSmsAlarm;
    bool? movementCallAlarm;
    bool? movementSmsAlarm;
    bool? relayCutOff;
    bool? spareCutOff;
    bool? powerAlarm;
    bool? movementAlarm;
    List<String> temp = AppUtil.getBinList(hex);
    speedCallAlarm = AppUtil.getBool(temp.length > 20 ? temp[20] : '0');
    speedSmsAlarm = AppUtil.getBool(temp.length > 7 ? temp[7] : '0');
    sosCallAlarm = AppUtil.getBool(temp.isNotEmpty ? temp[0] : '0');
    sosSmsAlarm = AppUtil.getBool(temp.length > 1 ? temp[1] : '0');
    securityChangeCallAlarm = AppUtil.getBool(temp.length > 9 ? temp[9] : '0');
    securityChangeSmsAlarm = AppUtil.getBool(temp.length > 8 ? temp[8] : '0');
    securityWarningsSmsAlarm =
        AppUtil.getBool(temp.length > 10 ? temp[10] : '0');
    mainPowerCallAlarm = AppUtil.getBool(temp.length > 21 ? temp[21] : '0');
    mainPowerSmsAlarm = AppUtil.getBool(temp.length > 13 ? temp[13] : '0');
    carOnCallAlarm = AppUtil.getBool(temp.length > 23 ? temp[23] : '0');
    carOnSmsAlarm = AppUtil.getBool(temp.length > 15 ? temp[15] : '0');
    accCutCallAlarm = AppUtil.getBool(temp.length > 22 ? temp[22] : '0');
    accCutSmsAlarm = AppUtil.getBool(temp.length > 14 ? temp[14] : '0');
    movementCallAlarm = AppUtil.getBool(temp.length > 26 ? temp[26] : '0');
    movementSmsAlarm = AppUtil.getBool(temp.length > 25 ? temp[25] : '0');
    relayCutOff = AppUtil.getBool(temp.length > 2 ? temp[2] : '0');
    spareCutOff = AppUtil.getBool(temp.length > 24 ? temp[24] : '0');
    powerAlarm = AppUtil.getBool(temp.length > 15 ? temp[15] : '0');
    movementAlarm = AppUtil.getBool(temp.length > 25 ? temp[25] : '0');

    return SmsCallMode(
      hex: hex,
      speedCallAlarm: speedCallAlarm,
      speedSmsAlarm: speedSmsAlarm,
      sosCallAlarm: sosCallAlarm,
      sosSmsAlarm: sosSmsAlarm,
      securityChangeCallAlarm: securityChangeCallAlarm,
      securityChangeSmsAlarm: securityChangeSmsAlarm,
      securityWarningsSmsAlarm: securityWarningsSmsAlarm,
      mainPowerCallAlarm: mainPowerCallAlarm,
      mainPowerSmsAlarm: mainPowerSmsAlarm,
      carOnCallAlarm: carOnCallAlarm,
      carOnSmsAlarm: carOnSmsAlarm,
      accCutCallAlarm: accCutCallAlarm,
      accCutSmsAlarm: accCutSmsAlarm,
      movementCallAlarm: movementCallAlarm,
      movementSmsAlarm: movementSmsAlarm,
      relayCutOff: relayCutOff,
      spareCutOff: spareCutOff,
      powerAlarm: powerAlarm,
      movementAlarm: movementAlarm,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['powerAlarm'] = powerAlarm;
    return data;
  }

  SmsCallMode clone() => SmsCallMode(
        hex: hex,
        speedCallAlarm: speedCallAlarm,
        speedSmsAlarm: speedSmsAlarm,
        sosCallAlarm: sosCallAlarm,
        sosSmsAlarm: sosSmsAlarm,
        securityChangeCallAlarm: securityChangeCallAlarm,
        securityChangeSmsAlarm: securityChangeSmsAlarm,
        securityWarningsSmsAlarm: securityWarningsSmsAlarm,
        mainPowerCallAlarm: mainPowerCallAlarm,
        mainPowerSmsAlarm: mainPowerSmsAlarm,
        carOnCallAlarm: carOnCallAlarm,
        carOnSmsAlarm: carOnSmsAlarm,
        accCutCallAlarm: accCutCallAlarm,
        accCutSmsAlarm: accCutSmsAlarm,
        movementCallAlarm: movementCallAlarm,
        movementSmsAlarm: movementSmsAlarm,
        relayCutOff: relayCutOff,
        spareCutOff: spareCutOff,
        powerAlarm: powerAlarm,
        movementAlarm: movementAlarm,
      );
}

class GPS {
  Loc? loc;
  num? speed;
  num? heading;
  num? altitude;
  String? ns;
  String? ew;

  GPS({
    this.loc,
    this.speed,
    this.heading,
    this.altitude,
    this.ns,
    this.ew,
  });

  GPS.fromJson(Map<String, dynamic> json) {
    loc = json['loc'] != null ? Loc.fromJson(json['loc']) : null;
    speed = json['speed'];
    heading = json['heading'];
    altitude = json['altitude'];
    ns = json['ns'];
    ew = json['ew'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (loc != null) {
      data['loc'] = loc!.toJson();
    }
    data['speed'] = speed;
    data['heading'] = heading;
    data['altitude'] = altitude;
    data['ns'] = ns;
    data['ew'] = ew;
    return data;
  }
}

class Loc {
  String? type;
  List<num>? coordinates;

  Loc({
    this.type,
    this.coordinates,
  });

  Loc.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<num>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class GSM {
  Loc? loc;
  num? sigQ;
  num? simCharge;

  GSM({
    this.loc,
    this.sigQ,
    this.simCharge,
  });

  GSM.fromJson(Map<String, dynamic> json) {
    loc = json['loc'] != null ? Loc.fromJson(json['loc']) : null;
    sigQ = json['sigQ'];
    simCharge = json['simCharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (loc != null) {
      data['loc'] = loc!.toJson();
    }
    data['sigQ'] = sigQ;
    data['simCharge'] = simCharge;
    return data;
  }
}

class Cell {
  num? id;
  num? loc;

  Cell({
    this.id,
    this.loc,
  });

  Cell.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loc = json['loc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['loc'] = loc;
    return data;
  }
}

class Mileage {
  num? timestamp;
  num? odometer;
  Data? data;

  Mileage({
    this.timestamp,
    this.odometer,
    this.data,
  });

  Mileage.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    odometer = json['odometer'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['odometer'] = odometer;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  num? acc;
  num? accl;
  num? speed;
  num? hyb;
  String? exc;

  Data({
    this.acc,
    this.accl,
    this.speed,
    this.hyb,
    this.exc,
  });

  Data.fromJson(Map<String, dynamic> json) {
    acc = json['ACC'];
    accl = json['ACCL'];
    speed = json['SPEED'];
    hyb = json['HYB'];
    exc = json['exc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ACC'] = acc;
    data['ACCL'] = accl;
    data['SPEED'] = speed;
    data['HYB'] = hyb;
    data['exc'] = exc;
    return data;
  }
}

class Odometer {
  num? timestamp;
  String? value;

  Odometer({
    this.timestamp,
    this.value,
  });

  Odometer.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    value = json['value'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['value'] = value;
    return data;
  }
}
