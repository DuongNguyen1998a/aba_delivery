class HistoryDetail {
  int id;
  String shipmenTID;
  String salarYELEMENT;
  double? salarYAMOUNT;
  String description;
  double? uniTPRICE;
  String status;
  String createdBy;
  String updatedBy;
  String createDate;
  String recordDate;
  String rowPointer;
  int noteExistsFlag;
  int inWorkflow;

  HistoryDetail({
    required this.id,
    required this.shipmenTID,
    required this.salarYELEMENT,
    required this.salarYAMOUNT,
    required this.description,
    required this.uniTPRICE,
    required this.status,
    required this.createdBy,
    required this.updatedBy,
    required this.createDate,
    required this.recordDate,
    required this.rowPointer,
    required this.noteExistsFlag,
    required this.inWorkflow,
  });

  factory HistoryDetail.fromJson(Map<String, dynamic> json) {
    return HistoryDetail(
      id: json['id'],
      shipmenTID: json['shipmenT_ID'],
      salarYELEMENT: json['salarY_ELEMENT'],
      salarYAMOUNT: json['salarY_AMOUNT'],
      description: json['description'],
      uniTPRICE: json['uniT_PRICE'],
      status: json['status'],
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
    data['id'] = id;
    data['shipmenT_ID'] = shipmenTID;
    data['salarY_ELEMENT'] = salarYELEMENT;
    data['salarY_AMOUNT'] = salarYAMOUNT;
    data['description'] = description;
    data['uniT_PRICE'] = uniTPRICE;
    data['status'] = status;
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
