class LoginModel {
  String token;
  String secretKey;

  LoginModel({
    required this.token,
    required this.secretKey,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'].toString(),
      secretKey: json['secretKey'].toString(),
    );
  }
}
