class GasTicket {
  String? ticketId;
  String? powerUnit;
  String? gasStationName;
  int? odoPrevious;
  int? odoCurrent;
  double? actualQty;
  double? appUnitPrice;
  int? status;
  int? appConfirm;
  String? imageActualQty;
  String? imageOdoCurrent;
  double? norm;
  double? qrCodeActualQty;

  GasTicket({
    required this.ticketId,
    required this.powerUnit,
    required this.gasStationName,
    required this.odoPrevious,
    required this.odoCurrent,
    required this.actualQty,
    required this.appUnitPrice,
    required this.status,
    required this.appConfirm,
    required this.imageActualQty,
    required this.imageOdoCurrent,
    required this.norm,
    required this.qrCodeActualQty,
  });

  factory GasTicket.fromJson(Map<String, dynamic> json) {
    return GasTicket(
      ticketId: json['ticketId'],
      powerUnit: json['powerUnit'],
      gasStationName: json['gasStationName'],
      odoPrevious: json['odoPrevious'],
      odoCurrent: json['odoCurrent'],
      actualQty: json['actualQty'],
      appUnitPrice: json['appUnitPrice'],
      status: json['status'],
      appConfirm: json['appConfirm'],
      imageActualQty: json['imageActualQty'],
      imageOdoCurrent: json['imageOdoCurrent'],
      norm: json['norm'],
      qrCodeActualQty: json['qrCode_ActualQty']
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ticketId'] = ticketId;
    data['powerUnit'] = powerUnit;
    data['gasStationName'] = gasStationName;
    data['odoPrevious'] = odoPrevious;
    data['odoCurrent'] = odoCurrent;
    data['actualQty'] = actualQty;
    data['appUnitPrice'] = appUnitPrice;
    data['status'] = status;
    data['appConfirm'] = appConfirm;
    data['imageActualQty'] = imageActualQty;
    data['imageOdoCurrent'] = imageOdoCurrent;
    data['norm'] = norm;
    data['qrCode_ActualQty'] = qrCodeActualQty;
    return data;
  }
}
