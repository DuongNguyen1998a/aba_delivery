class ShipmentAdvancePayment {
  String customerCode;
  String? powerUnitGID;
  String? shipmentGID;
  String atmShipmentID;
  String driverGID;
  String? driverName;
  String region;
  String packagedItem;
  String startTime;
  String city;

  ShipmentAdvancePayment({
    required this.customerCode,
    required this.powerUnitGID,
    required this.shipmentGID,
    required this.atmShipmentID,
    required this.driverGID,
    required this.driverName,
    required this.region,
    required this.packagedItem,
    required this.startTime,
    required this.city,
  });

  factory ShipmentAdvancePayment.fromJson(Map<String, dynamic> json) {
    return ShipmentAdvancePayment(
      customerCode: json['customerCode'],
      powerUnitGID: json['powerUnitGID'],
      shipmentGID: json['shipmentGID'],
      atmShipmentID: json['atmShipmentID'],
      driverGID: json['driverGID'],
      driverName: json['driverName'],
      region: json['region'],
      packagedItem: json['packagedItem'],
      startTime: json['startTime'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['customerCode'] = customerCode;
    data['powerUnitGID'] = powerUnitGID;
    data['shipmentGID'] = shipmentGID;
    data['atmShipmentID'] = atmShipmentID;
    data['driverGID'] = driverGID;
    data['driverName'] = driverName;
    data['region'] = region;
    data['packagedItem'] = packagedItem;
    data['startTime'] = startTime;
    data['city'] = city;
    return data;
  }
}
