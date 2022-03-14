class DieuDong {
  String atMSHIPMENTId;
  String createDate;

  DieuDong({
    required this.atMSHIPMENTId,
    required this.createDate,
  });

  factory DieuDong.fromJson(Map<String, dynamic> json) {
    return DieuDong(
      atMSHIPMENTId: json['atM_SHIPMENT_id'],
      createDate: json['createDate'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['atM_SHIPMENT_id'] = atMSHIPMENTId;
    data['createDate'] = createDate;
    return data;
  }
}
