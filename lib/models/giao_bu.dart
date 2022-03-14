class GiaoBu {
  String? storeCode;
  String? storeName;
  String? khachHang;
  String? address;
  String? atmShipmentID;

  GiaoBu({
    required this.storeCode,
    required this.storeName,
    required this.khachHang,
    required this.address,
    required this.atmShipmentID,
  });

  factory GiaoBu.fromJson(Map<String, dynamic> json) {
    return GiaoBu(
      storeCode: json['store_Code'],
      storeName: json['store_Name'],
      khachHang: json['khachHang'],
      address: json['address'],
      atmShipmentID: json['atmShipmentID'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_Code'] = storeCode;
    data['store_Name'] = storeName;
    data['khachHang'] = khachHang;
    data['address'] = address;
    data['atmShipmentID'] = atmShipmentID;
    return data;
  }
}
