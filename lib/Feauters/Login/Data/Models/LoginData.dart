class LoginData{
  String userName;
  String password;
  String deviceId;


  LoginData({
    required this.userName,
    required this.password,
    required this.deviceId,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      userName: json['userId'],
      password: json['password'],
      deviceId: json['deviceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      'deviceId': deviceId,
    };
  }


}