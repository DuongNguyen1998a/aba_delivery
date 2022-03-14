class PersonalContact {
  String locationGID;
  String customerCode;
  String phone;
  String personName;
  String lastReceivingTime;

  PersonalContact({
    required this.locationGID,
    required this.customerCode,
    required this.phone,
    required this.personName,
    required this.lastReceivingTime,
  });

  factory PersonalContact.fromJson(Map<String, dynamic> json) {
    return PersonalContact(
      locationGID: json['locationGID'],
      customerCode: json['customerCode'],
      phone: json['phone'],
      personName: json['personName'],
      lastReceivingTime: json['lastReceivingTime'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['locationGID'] = locationGID;
    data['customerCode'] = customerCode;
    data['phone'] = phone;
    data['personName'] = personName;
    data['lastReceivingTime'] = lastReceivingTime;
    return data;
  }
}
