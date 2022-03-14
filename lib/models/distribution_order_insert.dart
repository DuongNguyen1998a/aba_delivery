class DistributionOrderInsert {
  String createdBy;
  String powerUnit;
  double kilometers;
  double quantity;
  String appMessage;
  int gasStationId;
  double unitPrice;
  String driverId;

  DistributionOrderInsert({
      required this.createdBy,
      required this.powerUnit,
      required this.kilometers,
      required this.quantity,
      required this.appMessage,
      required this.gasStationId,
      required this.unitPrice,
      required this.driverId,
  });

  factory DistributionOrderInsert.fromJson(Map<String, dynamic> json) {
    return DistributionOrderInsert(
      createdBy: json['createdBy'],
      powerUnit: json['powerUnit'],
      kilometers: json['kilometers'],
      quantity: json['quantity'],
      appMessage: json['appMessage'],
      gasStationId: json['gasStationId'],
      unitPrice: json['unitPrice'],
      driverId: json['driverId'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['createdBy'] = createdBy;
    data['powerUnit'] = powerUnit;
    data['kilometers'] = kilometers;
    data['quantity'] = quantity;
    data['appMessage'] = appMessage;
    data['gasStationId'] = gasStationId;
    data['unitPrice'] = unitPrice;
    data['driverId'] = driverId;
    return data;
  }
}