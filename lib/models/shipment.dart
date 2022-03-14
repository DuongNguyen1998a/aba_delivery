class Shipment {
  String? customerCode;
  DateTime starTTIME;
  DateTime enDTIME;
  String driveRGID;
  String? poweRUNITGID;
  String atMSHIPMENTID;
  String mode;
  String routeno;
  bool roiKho;
  bool denKho;
  bool startPickup;
  bool donePickup;
  String packagedItemXID;
  String status;

  Shipment({
    required this.customerCode,
    required this.starTTIME,
    required this.enDTIME,
    required this.driveRGID,
    required this.poweRUNITGID,
    required this.atMSHIPMENTID,
    required this.mode,
    required this.routeno,
    required this.roiKho,
    required this.denKho,
    required this.startPickup,
    required this.donePickup,
    required this.packagedItemXID,
    required this.status,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      customerCode: json['customerCode'],
      starTTIME: DateTime.parse(json['starT_TIME']),
      enDTIME: DateTime.parse(json['enD_TIME']),
      driveRGID: json['driveR_GID'],
      poweRUNITGID: json['poweR_UNIT_GID'],
      atMSHIPMENTID: json['atM_SHIPMENT_ID'],
      mode: json['mode'],
      routeno: json['routeno'],
      roiKho: json['roiKho'],
      denKho: json['denKho'],
      startPickup: json['startPickup'],
      donePickup: json['donePickup'],
      packagedItemXID: json['packaged_Item_XID'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['customerCode'] = customerCode;
    data['starT_TIME'] = starTTIME;
    data['enD_TIME'] = enDTIME;
    data['driveR_GID'] = driveRGID;
    data['poweR_UNIT_GID'] = poweRUNITGID;
    data['atM_SHIPMENT_ID'] = atMSHIPMENTID;
    data['mode'] = mode;
    data['routeno'] = routeno;
    data['roiKho'] = roiKho;
    data['denKho'] = denKho;
    data['startPickup'] = startPickup;
    data['donePickup'] = donePickup;
    data['packaged_Item_XID'] = packagedItemXID;
    data['status'] = status;
    return data;
  }
}
