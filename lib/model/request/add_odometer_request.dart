class AddOdometerRequest {
  num? vehicleId;
  OdometerRequest? odometer;

  AddOdometerRequest({this.vehicleId, this.odometer});

  AddOdometerRequest.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicleId'];
    odometer = json['odometer'] != null
        ? OdometerRequest.fromJson(json['odometer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['vehicleId'] = vehicleId;
    if (odometer != null) {
      data['odometer'] = odometer!.toJson();
    }
    return data;
  }
}

class OdometerRequest {
  num? number;
  bool? setAsDefault;

  OdometerRequest({this.number, this.setAsDefault});

  OdometerRequest.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    setAsDefault = json['setAsDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['number'] = number;
    data['setAsDefault'] = setAsDefault;
    return data;
  }
}
