class ShipmentStop {
  String shipmenTGID;
  String stoPTYPE;
  String? storeCodeABA;
  String storeCode;
  String storeName;
  String? storeNameABA;
  String? addresSLINE;
  String atMSHIPMENTID;
  String planneDARRIVAL;
  bool mobileHub;
  bool isCompleted;
  String khachHang;
  String deliveryDate;
  int totalCarton;
  bool daToi;
  String? latToi;
  String? lngToi;
  String? gioToi;
  String? customerClientPhone;
  double totalWeight;
  String orderreleasEID;
  String packagedItemXID;
  String latStore;
  String lonStore;
  String locationNoABA;
  String vehicle;
  bool isDetails;
  String? billto;
  bool isExchange;
  bool isDocumentReturn;

  ShipmentStop({
    required this.shipmenTGID,
    required this.stoPTYPE,
    required this.storeCodeABA,
    required this.storeCode,
    required this.storeName,
    required this.storeNameABA,
    required this.addresSLINE,
    required this.atMSHIPMENTID,
    required this.planneDARRIVAL,
    required this.mobileHub,
    required this.isCompleted,
    required this.khachHang,
    required this.deliveryDate,
    required this.totalCarton,
    required this.daToi,
    required this.latToi,
    required this.lngToi,
    required this.gioToi,
    required this.customerClientPhone,
    required this.totalWeight,
    required this.orderreleasEID,
    required this.packagedItemXID,
    required this.latStore,
    required this.lonStore,
    required this.locationNoABA,
    required this.vehicle,
    required this.isDetails,
    required this.billto,
    required this.isExchange,
    required this.isDocumentReturn,
  });

  factory ShipmentStop.fromJson(Map<String, dynamic> json) {
    return ShipmentStop(
      shipmenTGID: json['shipmenT_GID'],
      stoPTYPE: json['stoP_TYPE'],
      storeCodeABA: json['store_Code_ABA'],
      storeCode: json['store_Code'],
      storeName: json['store_Name'],
      storeNameABA: json['store_Name_ABA'],
      addresSLINE: json['addresS_LINE'],
      atMSHIPMENTID: json['atM_SHIPMENT_ID'],
      planneDARRIVAL: json['planneD_ARRIVAL'],
      mobileHub: json['mobileHub'],
      isCompleted: json['isCompleted'],
      khachHang: json['khachHang'],
      deliveryDate: json['delivery_Date'],
      totalCarton: json['totalCarton'],
      daToi: json['daToi'],
      latToi: json['latToi'],
      lngToi: json['lngToi'],
      gioToi: json['gioToi'],
      customerClientPhone: json['customerClientPhone'],
      totalWeight: json['totalWeight'],
      orderreleasEID: json['orderreleasE_ID'],
      packagedItemXID: json['packaged_Item_XID'],
      latStore: json['lat_Store'],
      lonStore: json['lon_Store'],
      locationNoABA: json['locationNoABA'],
      vehicle: json['vehicle'],
      isDetails: json['isDetails'],
      billto: json['billto'],
      isExchange: json['isExchange'],
      isDocumentReturn: json['isDocumentReturn'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['shipmenT_GID'] = shipmenTGID;
    data['stoP_TYPE'] = stoPTYPE;
    data['store_Code_ABA'] = storeCodeABA;
    data['store_Code'] = storeCode;
    data['store_Name'] = storeName;
    data['store_Name_ABA'] = storeNameABA;
    data['addresS_LINE'] = addresSLINE;
    data['atM_SHIPMENT_ID'] = atMSHIPMENTID;
    data['planneD_ARRIVAL'] = planneDARRIVAL;
    data['mobileHub'] = mobileHub;
    data['isCompleted'] = isCompleted;
    data['khachHang'] = khachHang;
    data['delivery_Date'] = deliveryDate;
    data['totalCarton'] = totalCarton;
    data['daToi'] = daToi;
    data['latToi'] = latToi;
    data['lngToi'] = lngToi;
    data['gioToi'] = gioToi;
    data['customerClientPhone'] = customerClientPhone;
    data['totalWeight'] = totalWeight;
    data['orderreleasE_ID'] = orderreleasEID;
    data['packaged_Item_XID'] = packagedItemXID;
    data['lat_Store'] = latStore;
    data['lon_Store'] = lonStore;
    data['locationNoABA'] = locationNoABA;
    data['vehicle'] = vehicle;
    data['isDetails'] = isDetails;
    data['billto'] = billto;
    data['isExchange'] = isExchange;
    data['isDocumentReturn'] = isDocumentReturn;
    return data;
  }
}
