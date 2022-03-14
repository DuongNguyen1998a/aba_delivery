class LocationATMId {
  String atMSHIPMENTID;
  String? customerCode;
  String startTime;
  String packagedItem;

  LocationATMId({
    required this.atMSHIPMENTID,
    required this.customerCode,
    required this.startTime,
    required this.packagedItem,
  });

  factory LocationATMId.fromJson(Map<String, dynamic> json) {
    return LocationATMId(
      atMSHIPMENTID: json['atM_SHIPMENT_ID'],
      customerCode: json['customerCode'],
      startTime: json['startTime'],
      packagedItem: json['packagedItem'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['atM_SHIPMENT_ID'] = atMSHIPMENTID;
    data['customerCode'] = customerCode;
    data['startTime'] = startTime;
    data['packagedItem'] = packagedItem;
    return data;
  }
}
