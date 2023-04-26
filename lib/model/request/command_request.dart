class CommandRequest {
  CommandRequest({
    this.id,
    this.vehicleId,
    this.deviceId,
    this.cmd,
    this.payload,
    this.packetType,
    this.userId,
    this.createdTimestamp,
    this.cmdId,
  });

  String? type;
  String? id;
  num? vehicleId;
  String? deviceId;
  num? cmd;
  dynamic payload;
  num? packetType;
  num? userId;
  num? createdTimestamp;
  num? cmdId;

  CommandRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['_id'];
    vehicleId = json['vehicle_id'];
    deviceId = json['deviceId'];
    cmd = json['CMD'];
    payload = json['payload'];
    packetType = json['packetType'];
    userId = json['user_id'];
    createdTimestamp = json['createTimestamp'];
    cmdId = json['CMDID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['vehicleId'] = vehicleId;
    data['deviceId'] = deviceId;
    data['cmd'] = cmd;
    data['payload'] = payload;
    data['packetType'] = packetType;
    data['userId'] = userId;
    data['createdTimestamp'] = createdTimestamp;
    data['cmdId'] = cmdId;
    return data;
  }
}
