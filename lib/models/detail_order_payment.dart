class DetailOrderPayment {
  int id;
  String atmShipmentID;
  String powerUnit;
  String employeeID;
  String employeeName;
  String department;
  String customer;
  String? invoiceDate;
  int oPamount;
  int sEamount;
  int fiNamount;
  String advancePaymentType;
  String? description;
  int amount;
  int? amountAdjustment;
  String? uDWho;
  String? seApproved;
  String? finApproved;
  String? manager;
  String? opApproved;
  String? approveStatus;
  String? remark;
  String? fiNremark;
  String? sEremark;
  String? oPremark;
  String city;
  String startTime;

  DetailOrderPayment({
    required this.atmShipmentID,
    required this.powerUnit,
    required this.employeeID,
    required this.employeeName,
    required this.department,
    required this.customer,
    required this.advancePaymentType,
    required this.description,
    required this.amount,
    required this.city,
    required this.startTime,
    required this.amountAdjustment,
    required this.fiNamount,
    required this.oPamount,
    required this.sEamount,
    required this.id,
  });

  factory DetailOrderPayment.fromJson(Map<String, dynamic> json) {
    return DetailOrderPayment(
      atmShipmentID: json['atmShipmentID'],
      powerUnit: json['powerUnit'],
      employeeID: json['employeeID'],
      employeeName: json['employeeName'],
      department: json['department'],
      customer: json['customer'],
      advancePaymentType: json['advancePaymentType'],
      description: json['description'],
      amount: json['amount'],
      city: json['city'],
      startTime: json['startTime'],
      amountAdjustment: json['amountAdjustment'],
      fiNamount: json['fiNamount'],
      oPamount: json['oPamount'],
      sEamount: json['sEamount'],
      id: json['id'],
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
    data['advancePaymentType'] = advancePaymentType;
    data['description'] = description;
    data['amount'] = amount;
    data['city'] = city;
    data['startTime'] = startTime;
    return data;
  }


}
