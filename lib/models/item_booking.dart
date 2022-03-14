class ItemBooking {
  String? iD;
  int? actualReceived;
  double? actualWeightReceived;
  String? notes;
  String? updatedByDeliverer;
  String? latDelivered;
  String? lngDelivered;
  String? helpingStore;
  String? helpingReason;
  int? incompliance;
  int? residual;
  int? returnee;
  String? aTMShipmentID;

  ItemBooking({
    required this.iD,
    required this.actualReceived,
    required this.actualWeightReceived,
    required this.notes,
    required this.updatedByDeliverer,
    required this.latDelivered,
    required this.lngDelivered,
    required this.helpingStore,
    required this.helpingReason,
    required this.incompliance,
    required this.residual,
    required this.returnee,
    required this.aTMShipmentID,
  });

  factory ItemBooking.fromJson(Map<String, dynamic> json) {
    return ItemBooking(
      iD: json['ID'],
      actualReceived: json['ActualReceived'],
      actualWeightReceived: json['ActualWeightReceived'],
      notes: json['Notes'],
      updatedByDeliverer: json['UpdatedByDeliverer'],
      latDelivered: json['LatDelivered'],
      lngDelivered: json['LngDelivered'],
      helpingStore: json['HelpingStore'],
      helpingReason: json['HelpingReason'],
      incompliance: json['Incompliance'],
      residual: json['Residual'],
      returnee: json['Returnee'],
      aTMShipmentID: json['ATMShipmentID'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['ActualReceived'] = actualReceived;
    data['ActualWeightReceived'] = actualWeightReceived;
    data['Notes'] = notes;
    data['UpdatedByDeliverer'] = updatedByDeliverer;
    data['LatDelivered'] = latDelivered;
    data['LngDelivered'] = lngDelivered;
    data['HelpingStore'] = helpingStore;
    data['HelpingReason'] = helpingReason;
    data['Incompliance'] = incompliance;
    data['Residual'] = residual;
    data['Returnee'] = returnee;
    data['ATMShipmentID'] = aTMShipmentID;
    return data;
  }
}
