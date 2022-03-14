class HistoryDeliveryDetail {
  String planneDARRIVAL;
  String deliveryTime;
  String storeName;
  String storeCode;
  String atMShipmentID;
  String orderreleaseId;
  String packagedItemXID;
  String addresSLINE;
  int realNumDelivered;
  int totalCartonMasan;
  bool enough;
  int deficient;
  int broken;
  int residual;
  int badTemperature;
  String khachHang;
  int productRecall;
  int totalTray;
  int? adJ_deliver_qty;

  HistoryDeliveryDetail({
    required this.planneDARRIVAL,
    required this.deliveryTime,
    required this.storeName,
    required this.storeCode,
    required this.atMShipmentID,
    required this.orderreleaseId,
    required this.packagedItemXID,
    required this.addresSLINE,
    required this.realNumDelivered,
    required this.totalCartonMasan,
    required this.enough,
    required this.deficient,
    required this.broken,
    required this.residual,
    required this.badTemperature,
    required this.khachHang,
    required this.productRecall,
    required this.totalTray,
    required this.adJ_deliver_qty,
  });

  factory HistoryDeliveryDetail.fromJson(Map<String, dynamic> json) {
    return HistoryDeliveryDetail(
      planneDARRIVAL: json['planneD_ARRIVAL'],
      deliveryTime: json['delivery_Time'],
      storeName: json['store_Name'],
      storeCode: json['store_Code'],
      atMShipmentID: json['atM_Shipment_ID'],
      orderreleaseId: json['orderrelease_id'],
      packagedItemXID: json['packaged_Item_XID'],
      addresSLINE: json['addresS_LINE'],
      realNumDelivered: json['real_Num_Delivered'],
      totalCartonMasan: json['totalCartonMasan'],
      enough: json['enough'],
      deficient: json['deficient'],
      broken: json['broken'],
      residual: json['residual'],
      badTemperature: json['bad_Temperature'],
      khachHang: json['khachHang'],
      productRecall: json['productRecall'],
      totalTray: json['totalTray'],
      adJ_deliver_qty: json['adJ_deliver_qty'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['planneD_ARRIVAL'] = planneDARRIVAL;
    data['delivery_Time'] = deliveryTime;
    data['store_Name'] = storeName;
    data['store_Code'] = storeCode;
    data['atM_Shipment_ID'] = atMShipmentID;
    data['orderrelease_id'] = orderreleaseId;
    data['packaged_Item_XID'] = packagedItemXID;
    data['addresS_LINE'] = addresSLINE;
    data['real_Num_Delivered'] = realNumDelivered;
    data['totalCartonMasan'] = totalCartonMasan;
    data['enough'] = enough;
    data['deficient'] = deficient;
    data['broken'] = broken;
    data['residual'] = residual;
    data['bad_Temperature'] = badTemperature;
    data['khachHang'] = khachHang;
    data['productRecall'] = productRecall;
    data['totalTray'] = totalTray;
    data['adJ_deliver_qty'] = adJ_deliver_qty;
    return data;
  }
}
