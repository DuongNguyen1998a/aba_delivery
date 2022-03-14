class HistoryDelivery {
  String startTime;
  String endTime;
  String atmShipmentID;
  String deliveryTime;
  String customerCode;

  HistoryDelivery({
    required this.startTime,
    required this.endTime,
    required this.atmShipmentID,
    required this.deliveryTime,
    required this.customerCode,
  });

  factory HistoryDelivery.fromJson(Map<String, dynamic> json) {
    return HistoryDelivery(
      startTime: json['startTime'],
      endTime: json['endTime'],
      atmShipmentID: json['atmShipmentID'],
      deliveryTime: json['deliveryTime'],
      customerCode: json['customerCode'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['atmShipmentID'] = atmShipmentID;
    data['deliveryTime'] = deliveryTime;
    data['customerCode'] = customerCode;
    return data;
  }
}
