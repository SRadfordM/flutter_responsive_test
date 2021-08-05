class SignInCredentials {
  String username;
  String password;
  String deviceId;

  SignInCredentials({this.username, this.password, this.deviceId});

  Map<String, dynamic> toJson() =>
  {
    'email': username,
    'password': password,
    'deviceId': deviceId,
  };
}