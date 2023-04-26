class ForgetPasswordOTPRequestModel {
  final String phone;
  final int verifyKey;

  ForgetPasswordOTPRequestModel({
    required this.phone,
    required this.verifyKey,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'verifyKey': verifyKey,
    };
  }
}
