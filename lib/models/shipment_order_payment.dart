class ShipmentOrderPayment {
  String? customerCode;
  String? powerUnitGID;
  String atmShipmentID;
  String packagedItem;
  String startTime;
  int? amount;
  int? amountTotal;
  String? city;
  String? customerName;

  ShipmentOrderPayment({
    required this.customerCode,
    required this.atmShipmentID,
    required this.packagedItem,
    required this.startTime,
    required this.amount,
    required this.amountTotal,
    required this.powerUnitGID,
    required this.city,
    required this.customerName,
  });

  factory ShipmentOrderPayment.fromJson(Map<String, dynamic> json) {
    return ShipmentOrderPayment(
      customerCode: json['customerCode'],
      atmShipmentID: json['atmShipmentID'],
      packagedItem: json['packagedItem'],
      startTime: json['startTime'],
      amount: json['amount'],
      amountTotal: json['amountTotal'],
      powerUnitGID: json['powerUnitGID'],
      city: json['city'],
      customerName: json['customerName'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['customerCode'] = customerCode;
    data['atmShipmentID'] = atmShipmentID;
    data['packagedItem'] = packagedItem;
    data['startTime'] = startTime;
    data['amount'] = amount;
    data['amountTotal'] = amountTotal;
    data['powerUnitGID'] = powerUnitGID;
    data['city'] = city;
    data['customerName'] = customerName;
    return data;
  }

  static String getCustomerCode(String? customerCode, String packagedItem) {
    if (customerCode == null) {
      if (packagedItem.contains(',') &&
              packagedItem.contains('ABA.CHILLED_FOOD_0-5') ||
          packagedItem.contains(',') &&
              packagedItem.contains('ABA.FRESH_MEAT_0-4') ||
          packagedItem.contains(',') && packagedItem.contains('ABA.MEAT_0-5')) {
        return 'Hàng ghép thịt';
      } else if (packagedItem.contains('ABA.TRAY')) {
        return 'Hàng ghép thu khay';
      } else {
        return customerCode ?? '';
      }
    } else if (customerCode == 'VCM') {
      return 'Vin rau';
    } else if (customerCode == 'VCMFRESH') {
      return 'Vin thịt';
    } else if (customerCode == 'BHX' &&
            packagedItem.contains('ABA.ICE_0,ABA.MEAT_0-5') ||
        customerCode == 'BHX' &&
            packagedItem.contains('ABA.MEAT_0-5,ABA.ICE_0')) {
      return 'BHX thịt và đá';
    } else if (customerCode == 'BHX' && packagedItem.contains('ABA.ICE_0')) {
      return 'BHX đá';
    } else if (customerCode == 'BHX' && packagedItem.contains('ABA.TRAY')) {
      return 'BHX thu khay';
    } else if (customerCode == 'BHX' && packagedItem.contains('ABA.MEAT_0-5')) {
      return 'BHX thịt';
    } else {
      return customerCode;
    }
  }
}
