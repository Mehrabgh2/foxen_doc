class AppSettingRequest {
  AppSettingRelayRequest? relay;
  AppSettingRequestBody? movement;
  AppSettingRequestBody? acc;

  AppSettingRequest({this.relay, this.movement, this.acc});

  AppSettingRequest.fromJson(Map<String, dynamic> json) {
    relay = json['relay'] != null
        ? AppSettingRelayRequest.fromJson(json['relay'])
        : null;
    movement = json['movement'] != null
        ? AppSettingRequestBody.fromJson(json['movement'])
        : null;
    acc = json['ACC'] != null
        ? AppSettingRequestBody.fromJson(json['ACC'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (relay != null) {
      data['relay'] = relay!.toJson();
    }
    if (movement != null) {
      data['movement'] = movement!.toJson();
    }
    if (acc != null) {
      data['ACC'] = acc!.toJson();
    }
    return data;
  }
}

class AppSettingRelayRequest {
  String? type;
  bool? mapScreen;
  bool? vehicle;

  AppSettingRelayRequest({this.type, this.mapScreen, this.vehicle});

  AppSettingRelayRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    mapScreen = json['mapScreen'];
    vehicle = json['vehicle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['mapScreen'] = mapScreen;
    data['vehicle'] = vehicle;
    return data;
  }
}

class AppSettingRequestBody {
  bool? mapScreen;
  bool? vehicle;

  AppSettingRequestBody({this.mapScreen, this.vehicle});

  AppSettingRequestBody.fromJson(Map<String, dynamic> json) {
    mapScreen = json['mapScreen'];
    vehicle = json['vehicle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['mapScreen'] = mapScreen;
    data['vehicle'] = vehicle;
    return data;
  }
}
