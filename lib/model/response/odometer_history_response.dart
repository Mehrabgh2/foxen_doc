class OdometerHistoryResponse {
  OdometerHistoryResponse({required this.odometerHistories});

  final List<OdometerHistory> odometerHistories;

  factory OdometerHistoryResponse.fromJson(Map<String, dynamic> json) {
    List<OdometerHistory> odometerHistories = [];
    if (json['odometer'] != null) {
      json['odometer'].forEach((v) {
        odometerHistories.add(OdometerHistory.fromJson(v));
      });
    }
    return OdometerHistoryResponse(
      odometerHistories: odometerHistories,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    for (var element in odometerHistories) {
      data.addAll(element.toJson());
    }
    return data;
  }
}

class OdometerHistory {
  OdometerHistory({
    this.id,
    this.accountId,
    this.vehicleId,
    this.userId,
    this.odometer,
    this.oldOdometer,
    this.odometerTimestamp,
  });

  num? id;
  num? accountId;
  num? vehicleId;
  num? userId;
  num? odometer;
  num? oldOdometer;
  num? odometerTimestamp;

  factory OdometerHistory.fromJson(Map<String, dynamic> json) {
    final id = num.parse(json['_id'].toString());
    final accountId = num.parse(json['account_id'].toString());
    final vehicleId = num.parse(json['vehicle_id'].toString());
    final userId = num.parse(json['user_id'].toString());
    final odometer = num.parse(json['odometer'].toString()).toInt();
    final oldOdometer = num.parse(json['oldodometer'].toString()).toInt();
    final odometerTimestamp = num.parse(json['odometertimestamp'].toString());
    return OdometerHistory(
      id: id,
      accountId: accountId,
      vehicleId: vehicleId,
      userId: userId,
      odometer: odometer,
      oldOdometer: oldOdometer,
      odometerTimestamp: odometerTimestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'account_id': accountId,
        'vehicle_id': vehicleId,
        'user_id': userId,
        'odometer': odometer,
        'oldodometer': oldOdometer,
        'odometertimestamp': odometerTimestamp,
      };
}
