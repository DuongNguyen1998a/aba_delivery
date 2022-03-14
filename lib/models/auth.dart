class Auth {
  String accessToken;
  String tokenType;
  String userName;
  String fullName;
  String userId;
  String isBiker;
  String driverId;
  String dob;
  String region;
  String position;
  String site;

  Auth(
      {required this.accessToken,
      required this.tokenType,
      required this.userName,
      required this.fullName,
      required this.userId,
      required this.isBiker,
      required this.driverId,
      required this.dob,
      required this.region,
      required this.position,
      required this.site});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      userName: json['userName'],
      fullName: json['fullName'],
      userId: json['userId'],
      isBiker: json['isBiker'],
      driverId: json['MaNhanVien'],
      dob: json['NgaySinh'],
      region: json['Region'],
      position: json['Position'],
      site: json['site'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['userName'] = userName;
    data['fullName'] = fullName;
    data['userId'] = userId;
    data['isBiker'] = isBiker;
    data['MaNhanVien'] = driverId;
    data['NgaySinh'] = dob;
    data['Region'] = region;
    data['Position'] = position;
    data['site'] = site;
    return data;
  }
}
