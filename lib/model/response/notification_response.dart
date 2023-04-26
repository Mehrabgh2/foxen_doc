class NotificationResponse {
  NotificationResponse({required this.notifications});

  final List<NotificationModel> notifications;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    List<NotificationModel> notifications = [];
    if (json['notifications'] != null) {
      json['notifications'].forEach((v) {
        notifications.add(NotificationModel.fromJson(v));
      });
    }
    return NotificationResponse(
      notifications: notifications,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    for (var element in notifications) {
      data.addAll(element.toJson());
    }
    return data;
  }
}

class NotificationModel {
  int? id;
  int? accountId;
  int? userId;
  int? vehicleId;
  String? type;
  String? title;
  String? message;
  String? sentTime;
  Reference? reference;
  int? status;
  bool? archive;
  String? subtype;

  NotificationModel({
    this.id,
    this.accountId,
    this.userId,
    this.vehicleId,
    this.type,
    this.title,
    this.message,
    this.sentTime,
    this.reference,
    this.status,
    this.archive,
    this.subtype,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    accountId = json['account_id'];
    userId = json['user_id'];
    vehicleId = json['vehicle_id'];
    type = json['type'];
    title = json['title'];
    message = json['message'];
    sentTime = json['sent_time'];
    reference = json['reference'] != null
        ? Reference.fromJson(json['reference'])
        : null;
    status = json['status'];
    archive = json['archive'];
    subtype = json['subtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['account_id'] = accountId;
    data['user_id'] = userId;
    data['vehicle_id'] = vehicleId;
    data['type'] = type;
    data['title'] = title;
    data['message'] = message;
    data['sent_time'] = sentTime;
    if (reference != null) {
      data['reference'] = reference!.toJson();
    }
    data['status'] = status;
    data['archive'] = archive;
    data['subtype'] = subtype;
    return data;
  }
}

class Reference {
  String? type;
  int? id;
  int? vehicleId;

  Reference({
    this.type,
    this.id,
    this.vehicleId,
  });

  Reference.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    vehicleId = json['vehicleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['id'] = id;
    data['vehicleId'] = vehicleId;
    return data;
  }
}
