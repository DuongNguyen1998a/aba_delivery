class GiaoBuDetail {
  int rowId;
  String? itemCode;
  String? itemName;
  double? soBich;
  double? actualReceived;
  int giaoBu;

  GiaoBuDetail({
    required this.rowId,
    required this.itemCode,
    required this.itemName,
    required this.soBich,
    required this.actualReceived,
    required this.giaoBu,
  });

  factory GiaoBuDetail.fromJson(Map<String, dynamic> json) {
    return GiaoBuDetail(
      rowId: json['rowId'],
      itemCode: json['item_Code'],
      itemName: json['item_Name'],
      soBich: json['soBich'],
      actualReceived: json['actual_Received'],
      giaoBu: json['giaoBu'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rowId'] = rowId;
    data['item_Code'] = itemCode;
    data['item_Name'] = itemName;
    data['soBich'] = soBich;
    data['actual_Received'] = actualReceived;
    data['giaoBu'] = giaoBu;
    return data;
  }
}
