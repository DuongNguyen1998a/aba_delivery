class DeNghiThanhToan {
  String atmShipmentID;
  String powerUnit;
  String employeeID;
  String employeeName;
  String department;
  String customer;
  String? invoiceNumber;
  String advancePaymentType;
  int amount;
  int amountAdjustment;
  int amountTotal;
  String startTime;

  DeNghiThanhToan({
    required this.atmShipmentID,
    required this.powerUnit,
    required this.employeeID,
    required this.employeeName,
    required this.department,
    required this.customer,
    required this.invoiceNumber,
    required this.advancePaymentType,
    required this.amount,
    required this.amountAdjustment,
    required this.amountTotal,
    required this.startTime,
  });

  factory DeNghiThanhToan.fromJson(Map<String, dynamic> json) {
    return DeNghiThanhToan(
      atmShipmentID: json['atmShipmentID'],
      powerUnit: json['powerUnit'],
      employeeID: json['employeeID'],
      employeeName: json['employeeName'],
      department: json['department'],
      customer: json['customer'],
      invoiceNumber: json['invoiceNumber'],
      advancePaymentType: json['advancePaymentType'],
      amount: json['amount'],
      amountAdjustment: json['amountAdjustment'],
      amountTotal: json['amountTotal'],
      startTime: json['startTime'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['atmShipmentID'] = atmShipmentID;
    data['powerUnit'] = powerUnit;
    data['employeeID'] = employeeID;
    data['employeeName'] = employeeName;
    data['department'] = department;
    data['customer'] = customer;
    data['invoiceNumber'] = invoiceNumber;
    data['advancePaymentType'] = advancePaymentType;
    data['amount'] = amount;
    data['amountAdjustment'] = amountAdjustment;
    data['amountTotal'] = amountTotal;
    data['startTime'] = startTime;
    return data;
  }
}
