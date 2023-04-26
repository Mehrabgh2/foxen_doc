import '../foxen_device.dart';

class SecurityHistoryResponse {
  SecurityHistoryResponse({required this.securityHistories});

  final List<Security> securityHistories;

  factory SecurityHistoryResponse.fromJson(Map<String, dynamic> json) {
    List<Security> securityHistories = [];
    if (json['history'] != null) {
      json['history'].forEach((v) {
        securityHistories.add(Security.fromJson(v));
      });
    }
    return SecurityHistoryResponse(
      securityHistories: securityHistories,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    for (var element in securityHistories) {
      data.addAll(element.toJson());
    }
    return data;
  }
}
