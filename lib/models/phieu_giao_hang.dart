class PhieuGiaoHang {
  int rowId;
  int xdocKDocEntry;
  int routeID;
  String storeCode;
  String storeName;
  String deliveryDate;
  String itemCode;
  String itemName;
  double soBich;
  double soKi;
  String divUnit;
  double actualReceived;
  String? notes;
  String created;
  Null createdBy;
  Null modified;
  Null modifiedBy;
  Null itemEventId;
  Null khachHang;
  Null lat;
  Null lng;
  Null chNhanDum;
  Null lyDoNhanDum;
  Null atMSHIPMENTID;
  String? orderreleaseId;
  String? packagedItemXID;
  String? deliveryType;
  int thieu;
  int thua;
  int traVe;
  Null channelCode;
  Null documentName;
  Null documentReturn;
  Null customerID;
  Null invoice;
  bool isChecked = false;
  bool isShowDetail = false;
  double slTuKho;
  double slGiaoCH;
  bool cbThieu = false;
  int valueCbThieu = 0;
  bool cbDu = false;
  int valueCbDu = 0;
  bool cbTraVe = false;
  int valueCbTraVe = 0;

  PhieuGiaoHang({
    required this.rowId,
    required this.xdocKDocEntry,
    required this.routeID,
    required this.storeCode,
    required this.storeName,
    required this.deliveryDate,
    required this.itemCode,
    required this.itemName,
    required this.soBich,
    required this.soKi,
    required this.divUnit,
    required this.actualReceived,
    required this.notes,
    required this.created,
    required this.createdBy,
    required this.modified,
    required this.modifiedBy,
    required this.itemEventId,
    required this.khachHang,
    required this.lat,
    required this.lng,
    required this.chNhanDum,
    required this.lyDoNhanDum,
    required this.atMSHIPMENTID,
    required this.orderreleaseId,
    required this.packagedItemXID,
    required this.deliveryType,
    required this.thieu,
    required this.thua,
    required this.traVe,
    required this.channelCode,
    required this.documentName,
    required this.documentReturn,
    required this.customerID,
    required this.invoice,
    required this.isChecked,
    required this.isShowDetail,
    required this.slTuKho,
    required this.slGiaoCH,
    required this.cbThieu,
    required this.valueCbThieu,
    required this.cbDu,
    required this.valueCbDu,
    required this.cbTraVe,
    required this.valueCbTraVe,
  });

  factory PhieuGiaoHang.fromJson(Map<String, dynamic> json) {
    return PhieuGiaoHang(
      rowId: json['rowId'],
      xdocKDocEntry: json['xdocK_Doc_Entry'],
      routeID: json['route_ID'],
      storeCode: json['store_Code'],
      storeName: json['store_Name'],
      deliveryDate: json['delivery_Date'],
      itemCode: json['item_Code'],
      itemName: json['item_Name'],
      soBich: json['soBich'],
      soKi: json['soKi'],
      divUnit: json['div_Unit'],
      actualReceived: json['actual_Received'],
      notes: json['notes'],
      created: json['created'],
      createdBy: json['createdBy'],
      modified: json['modified'],
      modifiedBy: json['modifiedBy'],
      itemEventId: json['item_event_id'],
      khachHang: json['khachHang'],
      lat: json['lat'],
      lng: json['lng'],
      chNhanDum: json['chNhanDum'],
      lyDoNhanDum: json['lyDoNhanDum'],
      atMSHIPMENTID: json['atM_SHIPMENT_ID'],
      orderreleaseId: json['orderrelease_id'],
      packagedItemXID: json['packaged_Item_XID'],
      deliveryType: json['deliveryType'],
      thieu: json['thieu'],
      thua: json['thua'],
      traVe: json['traVe'],
      channelCode: json['channelCode'],
      documentName: json['documentName'],
      documentReturn: json['documentReturn'],
      customerID: json['customerID'],
      invoice: json['invoice'],
      isChecked: false,
      isShowDetail: false,
      slTuKho: json['soBich'],
      slGiaoCH: json['soBich'],
      cbThieu: false,
      valueCbThieu: 0,
      cbDu: false,
      valueCbDu: 0,
      cbTraVe: false,
      valueCbTraVe: 0,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['rowId'] = rowId;
    data['xdocK_Doc_Entry'] = xdocKDocEntry;
    data['route_ID'] = routeID;
    data['store_Code'] = storeCode;
    data['store_Name'] = storeName;
    data['delivery_Date'] = deliveryDate;
    data['item_Code'] = itemCode;
    data['item_Name'] = itemName;
    data['soBich'] = soBich;
    data['soKi'] = soKi;
    data['div_Unit'] = divUnit;
    data['actual_Received'] = actualReceived;
    data['notes'] = notes;
    data['created'] = created;
    data['createdBy'] = createdBy;
    data['modified'] = modified;
    data['modifiedBy'] = modifiedBy;
    data['item_event_id'] = itemEventId;
    data['khachHang'] = khachHang;
    data['lat'] = lat;
    data['lng'] = lng;
    data['chNhanDum'] = chNhanDum;
    data['lyDoNhanDum'] = lyDoNhanDum;
    data['atM_SHIPMENT_ID'] = atMSHIPMENTID;
    data['orderrelease_id'] = orderreleaseId;
    data['packaged_Item_XID'] = packagedItemXID;
    data['deliveryType'] = deliveryType;
    data['thieu'] = thieu;
    data['thua'] = thua;
    data['traVe'] = traVe;
    data['channelCode'] = channelCode;
    data['documentName'] = documentName;
    data['documentReturn'] = documentReturn;
    data['customerID'] = customerID;
    data['invoice'] = invoice;
    data['isChecked'] = isChecked;
    data['isShowDetail'] = isShowDetail;
    data['slTuKho'] = slTuKho;
    data['slGiaoCH'] = slGiaoCH;
    data['cbThieu'] = cbThieu;
    data['valueCbThieu'] = valueCbThieu;
    data['cbDu'] = cbDu;
    data['valueCbDu'] = valueCbDu;
    data['cbTraVe'] = cbTraVe;
    data['valueCbTraVe'] = valueCbTraVe;
    return data;
  }
}
