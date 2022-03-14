class History {
  Null otMSHIPMENTID;
  String shipmenTID;
  String tranSDATE;
  String driveRID;
  String driveRNAME;
  double salary;
  String customeRNAME;
  String status;
  String description;
  String comment;
  String createdBy;
  String updatedBy;
  String createDate;
  String recordDate;
  String rowPointer;
  int noteExistsFlag;
  int inWorkflow;

  History({
    required this.otMSHIPMENTID,
    required this.shipmenTID,
    required this.tranSDATE,
    required this.driveRID,
    required this.driveRNAME,
    required this.salary,
    required this.customeRNAME,
    required this.status,
    required this.description,
    required this.comment,
    required this.createdBy,
    required this.updatedBy,
    required this.createDate,
    required this.recordDate,
    required this.rowPointer,
    required this.noteExistsFlag,
    required this.inWorkflow,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      otMSHIPMENTID: json['otM_SHIPMENT_ID'],
      shipmenTID: json['shipmenT_ID'],
      tranSDATE: json['tranS_DATE'],
      driveRID: json['driveR_ID'],
      driveRNAME: json['driveR_NAME'],
      salary: json['salary'],
      customeRNAME: json['customeR_NAME'],
      status: json['status'],
      description: json['description'],
      comment: json['comment'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createDate: json['createDate'],
      recordDate: json['recordDate'],
      rowPointer: json['rowPointer'],
      noteExistsFlag: json['noteExistsFlag'],
      inWorkflow: json['inWorkflow'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['otM_SHIPMENT_ID'] = otMSHIPMENTID;
    data['shipmenT_ID'] = shipmenTID;
    data['tranS_DATE'] = tranSDATE;
    data['driveR_ID'] = driveRID;
    data['driveR_NAME'] = driveRNAME;
    data['salary'] = salary;
    data['customeR_NAME'] = customeRNAME;
    data['status'] = status;
    data['description'] = description;
    data['comment'] = comment;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createDate'] = createDate;
    data['recordDate'] = recordDate;
    data['rowPointer'] = rowPointer;
    data['noteExistsFlag'] = noteExistsFlag;
    data['inWorkflow'] = inWorkflow;
    return data;
  }
}
