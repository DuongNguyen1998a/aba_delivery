class GasLimit {
  String? powerUnit;
  int? gasLimit;
  int? checkExists;
  int? reqStatus;

  GasLimit({
    required this.powerUnit,
    required this.gasLimit,
    required this.checkExists,
    required this.reqStatus,
  });

  factory GasLimit.fromJson(Map<String, dynamic> json) {
    return GasLimit(
      powerUnit: json['powerUnit'],
      gasLimit: json['gasLimit'],
      checkExists: json['checkExists'],
      reqStatus: json['reqStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['powerUnit'] = powerUnit;
    data['gasLimit'] = gasLimit;
    data['checkExists'] = checkExists;
    data['reqStatus'] = reqStatus;
    return data;
  }
}
