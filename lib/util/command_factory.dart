import '../enum/command_subtype.dart';
import '../enum/command_type.dart';
import '../model/command.dart';
import '../model/foxen_device.dart';

class CommandFactory {
  static Command createCommand(FoxenDevice device, CommandSubType type) {
    num vehicleId = device.vehicle?.value.id ?? 0;
    String deviceId = device.device?.mongoId ?? '';
    String payload = '12345';
    int packetType = 3;
    int cmd = 0;
    CommandType cmdType = CommandType.command;
    switch (type) {
      case CommandSubType.turnOnRelay:
        cmd = 2;
        break;
      case CommandSubType.turnOffRelay:
        cmd = 1;
        break;
      case CommandSubType.turnOnFuel:
        cmd = 18;
        break;
      case CommandSubType.turnOffFuel:
        cmd = 17;
        break;
      case CommandSubType.muteLock:
        cmdType = CommandType.security;
        cmd = 34;
        break;
      case CommandSubType.lock:
        cmdType = CommandType.security;
        cmd = 32;
        break;
      case CommandSubType.unlock:
        cmdType = CommandType.security;
        cmd = 33;
        break;
      case CommandSubType.trunk:
        cmdType = CommandType.security;
        cmd = 35;
        break;
      case CommandSubType.alarm:
        cmdType = CommandType.security;
        cmd = 36;
        break;
      case CommandSubType.onCarwashMode:
        cmdType = CommandType.security;
        cmd = 40;
        break;
      case CommandSubType.offCarwashMode:
        cmdType = CommandType.security;
        cmd = 41;
    }
    return Command(
      type: cmdType,
      vehicleId: vehicleId,
      deviceId: deviceId,
      cmd: cmd,
      payload: payload,
      packetType: packetType,
    );
  }

  static Command createSecurityCommand(FoxenDevice device, List<bool> states) {
    num vehicleId = device.vehicle?.value.id ?? 0;
    String deviceId = device.device?.mongoId ?? '';
    int packetType = 3;
    int cmd = 42;
    List<int> serverStates = List.generate(7, (index) => 0);
    serverStates[0] = states[1] ? 1 : 0;
    serverStates[1] = states[3] ? 1 : 0;
    serverStates[2] = states[0] ? 1 : 0;
    serverStates[3] = states[4] ? 1 : 0;
    serverStates[4] = states[7] ? 1 : 0;
    serverStates[5] = states[5] ? 1 : 0;
    serverStates[6] = states[2] ? 1 : 0;
    for (int i = serverStates.length - 1; i >= 0; i--) {
      if (serverStates[i] == 1) {
        break;
      } else {
        serverStates.removeAt(i);
      }
    }
    String joined = serverStates.join();
    String payload = (int.parse(
            joined.isEmpty ? '0' : joined.split('').reversed.join(),
            radix: 2))
        .toString();
    return Command(
      type: CommandType.command,
      vehicleId: vehicleId,
      deviceId: deviceId,
      cmd: cmd,
      payload: payload,
      packetType: packetType,
    );
  }
}
