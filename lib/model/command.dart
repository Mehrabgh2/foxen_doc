import '../enum/command_type.dart';

class Command {
  CommandType type;
  String deviceId;
  num vehicleId;
  int cmd;
  String? payload;
  int? packetType;

  Command({
    required this.vehicleId,
    required this.deviceId,
    required this.cmd,
    this.type = CommandType.command,
    this.packetType = 3,
    this.payload = "12345",
  });

  Map<String, dynamic> toJson() {
    return {
      'vehicle_id': vehicleId,
      'deviceId': deviceId,
      'CMD': cmd,
      'payload': payload,
      'packetType': packetType,
    };
  }
}
