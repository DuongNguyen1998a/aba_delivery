class DeNghiThanhToanDetail {
  int id;
  String atmShipmentID;
  String powerUnit;
  String employeeID;
  String employeeName;
  String department;
  String customer;
  String invoiceDate;
  int oPamount;
  int sEamount;
  int fiNamount;
  String advancePaymentType;
  String description;
  int amount;
  int amountAdjustment;
  String udWho;
  String seApproved;
  String finApproved;
  String manager;
  String techManagerApproved;
  String technicalApproved;
  String opApproved;
  String approveStatus;
  String? remark;
  String? finRemark;
  String? seRemark;
  String? opRemark;

  DeNghiThanhToanDetail({
    required this.id,
    required this.atmShipmentID,
    required this.powerUnit,
    required this.employeeID,
    required this.employeeName,
    required this.department,
    required this.customer,
    required this.invoiceDate,
    required this.oPamount,
    required this.sEamount,
    required this.fiNamount,
    required this.advancePaymentType,
    required this.description,
    required this.amount,
    required this.amountAdjustment,
    required this.udWho,
    required this.seApproved,
    required this.finApproved,
    required this.manager,
    required this.techManagerApproved,
    required this.technicalApproved,
    required this.opApproved,
    required this.approveStatus,
    required this.remark,
    required this.finRemark,
    required this.seRemark,
    required this.opRemark,
  });

  factory DeNghiThanhToanDetail.fromJson(Map<String, dynamic> json) {
    return DeNghiThanhToanDetail(
      id: json['id'],
      atmShipmentID: json['atmShipmentID'],
      powerUnit: json['powerUnit'],
      employeeID: json['employeeID'],
      employeeName: json['employeeName'],
      department: json['department'],
      customer: json['customer'],
      invoiceDate: json['invoiceDate'],
      oPamount: json['oPamount'],
      sEamount: json['sEamount'],
      fiNamount: json['fiNamount'],
      advancePaymentType: json['advancePaymentType'],
      description: json['description'],
      amount: json['amount'],
      amountAdjustment: json['amountAdjustment'],
      udWho: json['udWho'],
      seApproved: json['seApproved'],
      finApproved: json['finApproved'],
      manager: json['manager'],
      techManagerApproved: json['techManagerApproved'],
      technicalApproved: json['technicalApproved'],
      opApproved: json['opApproved'],
      approveStatus: json['approveStatus'],
      remark: json['remark'],
      finRemark: json['finRemark'],
      seRemark: json['seRemark'],
      opRemark: json['opRemark'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['atmShipmentID'] = atmShipmentID;
    data['powerUnit'] = powerUnit;
    data['employeeID'] = employeeID;
    data['employeeName'] = employeeName;
    data['department'] = department;
    data['customer'] = customer;
    data['invoiceDate'] = invoiceDate;
    data['oPamount'] = oPamount;
    data['sEamount'] = sEamount;
    data['fiNamount'] = fiNamount;
    data['advancePaymentType'] = advancePaymentType;
    data['description'] = description;
    data['amount'] = amount;
    data['amountAdjustment'] = amountAdjustment;
    data['udWho'] = udWho;
    data['seApproved'] = seApproved;
    data['finApproved'] = finApproved;
    data['manager'] = manager;
    data['techManagerApproved'] = techManagerApproved;
    data['technicalApproved'] = technicalApproved;
    data['opApproved'] = opApproved;
    data['approveStatus'] = approveStatus;
    data['remark'] = remark;
    data['finRemark'] = finRemark;
    data['seRemark'] = seRemark;
    data['opRemark'] = opRemark;
    return data;
  }
}
