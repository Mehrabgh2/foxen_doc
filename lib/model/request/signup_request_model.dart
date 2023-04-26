class SignupRequestModel {
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final String vehicleName;
  final String phone;
  final String address;
  final String userType;
  final Map<String, dynamic> companyInfo;
  final String deviceSerialNumber;
  final String deviceWarrantyNumber;

  SignupRequestModel({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.vehicleName,
    required this.phone,
    required this.address,
    required this.userType,
    required this.companyInfo,
    required this.deviceSerialNumber,
    required this.deviceWarrantyNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
      'vehicleName': vehicleName,
      'phone': phone,
      'address': address,
      'userType': userType,
      'companyInfo': companyInfo,
      'deviceSerialNumber': deviceSerialNumber,
      'deviceWarrantyNumber': deviceWarrantyNumber,
    };
  }
}
