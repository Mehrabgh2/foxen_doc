class LoginRequestModel {
  final String username;
  final String password;

  LoginRequestModel({
    required this.username,
    required this.password,
  });

  Map<String, String> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
