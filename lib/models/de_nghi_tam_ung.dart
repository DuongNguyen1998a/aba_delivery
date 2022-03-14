class DeNghiTamUng {
  int id;
  String? atmShipmentID;
  String? otmsHipmentID;
  String? powerUnit;
  String employeeID;
  String employeeName;
  String department;
  String? customer;
  String invoiceDate;
  String invoiceNumber;
  String advancePaymentType;
  String? description;
  int amount;
  String finApproved;
  String seApproved;
  String opApproved;
  String manager;
  String createDate;
  String? remark;
  int finAmount;
  int opAmount;
  String finRemark;
  String opRemark;

  DeNghiTamUng({
    required this.id,
    required this.atmShipmentID,
    required this.otmsHipmentID,
    required this.powerUnit,
    required this.employeeID,
    required this.employeeName,
    required this.department,
    required this.customer,
    required this.invoiceDate,
    required this.invoiceNumber,
    required this.advancePaymentType,
    required this.description,
    required this.amount,
    required this.finApproved,
    required this.seApproved,
    required this.opApproved,
    required this.manager,
    required this.createDate,
    required this.remark,
    required this.finAmount,
    required this.opAmount,
    required this.finRemark,
    required this.opRemark,
  });

  factory DeNghiTamUng.fromJson(Map<String, dynamic> json) {
    return DeNghiTamUng(
      id: json['id'],
      atmShipmentID: json['atmShipmentID'],
      otmsHipmentID: json['otmsHipmentID'],
      powerUnit: json['powerUnit'],
      employeeID: json['employeeID'],
      employeeName: json['employeeName'],
      department: json['department'],
      customer: json['customer'],
      invoiceDate: json['invoiceDate'],
      invoiceNumber: json['invoiceNumber'],
      advancePaymentType: json['advancePaymentType'],
      description: json['description'],
      amount: json['amount'],
      finApproved: json['finApproved'],
      seApproved: json['seApproved'],
      opApproved: json['opApproved'],
      manager: json['manager'],
      createDate: json['createDate'],
      remark: json['remark'],
      finAmount: json['finAmount'],
      opAmount: json['opAmount'],
      finRemark: json['finRemark'],
      opRemark: json['opRemark'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['atmShipmentID'] = atmShipmentID;
    data['otmsHipmentID'] = otmsHipmentID;
    data['powerUnit'] = powerUnit;
    data['employeeID'] = employeeID;
    data['employeeName'] = employeeName;
    data['department'] = department;
    data['customer'] = customer;
    data['invoiceDate'] = invoiceDate;
    data['invoiceNumber'] = invoiceNumber;
    data['advancePaymentType'] = advancePaymentType;
    data['description'] = description;
    data['amount'] = amount;
    data['finApproved'] = finApproved;
    data['seApproved'] = seApproved;
    data['opApproved'] = opApproved;
    data['manager'] = manager;
    data['createDate'] = createDate;
    data['remark'] = remark;
    data['finAmount'] = finAmount;
    data['opAmount'] = opAmount;
    data['finRemark'] = finRemark;
    data['opRemark'] = opRemark;
    return data;
  }
}
