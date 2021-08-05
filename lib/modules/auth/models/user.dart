class User {
  String id;
  String username;
  String email;
  List<String> roles;
  String tokenType;
  String accessToken;
  String companyId;
  bool isActive;

  User({this.id, this.username, this.email, this.tokenType,
      this.accessToken, this.roles, this.companyId, this.isActive});

  User.from(User user) {
    this.id = user.id;
    this.username = user.username;
    this.email = user.email;
    this.roles = user.roles;
    this.tokenType = user.tokenType;
    this.accessToken = user.accessToken;
    this.companyId = user.companyId;
    this.isActive = user.isActive;
  }

  Map<String, dynamic> toJson() =>
  {
    'id': id,
    'username': username,
    'email': email,
    'roles': roles,
    'tokenType': tokenType,
    'accessToken': accessToken,
    'companyId': companyId,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      roles: new List<String>.from(json['roles']),
      tokenType: json['tokenType'],
      accessToken: json['accessToken'],
      companyId: json['companyId'],
    );
  }

  Map<String, dynamic> toPersistence() =>
  {
    'user': id,
    'email': email,
    'token_type': tokenType,
    'access_token': accessToken,
    'company_id': companyId,
    'is_active': isActive == true ? 1 : 0,
  };

  factory User.fromPersistence(Map<String, dynamic> json) {
    return User(
      id: json['user'],
      email: json['email'],
      tokenType: json['token_type'],
      accessToken: json['access_token'],
      companyId: json['company_id'],
      isActive: json['is_active'] == 1 ? true : false,
    );
  }

  String toString() {
    return "id: $id, username: $username, email: $email, companyId: $companyId, tokenType: $tokenType, accessToken: $accessToken, isActive: $isActive, roles: $roles";
  }
}