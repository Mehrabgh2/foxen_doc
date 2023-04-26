import '../enum/setting_command_type.dart';

class SettingCommand {
  List<SettingCommandType> types;
  String deviceId;
  num vehicleId;
  List<num?> cmd;
  int? packetType;

  SettingCommand({
    required this.types,
    required this.deviceId,
    required this.vehicleId,
    required this.cmd,
    this.packetType = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'vehicle_id': vehicleId,
      'packetType': packetType,
      for (int i = 0; i < types.length; i++)
        types.elementAt(i).name: cmd.elementAt(i),
    };
  }
}
