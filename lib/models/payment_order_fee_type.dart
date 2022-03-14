class PaymentOrderFeeType {
  String? iDLoaiPhi;
  String? tenLoaiPhi;

  PaymentOrderFeeType({required this.iDLoaiPhi, required this.tenLoaiPhi});

  factory PaymentOrderFeeType.fromJson(Map<String, dynamic> json) {
    return PaymentOrderFeeType(
      iDLoaiPhi: json['iD_LoaiPhi'],
      tenLoaiPhi : json['tenLoaiPhi'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['iD_LoaiPhi'] = iDLoaiPhi;
    data['tenLoaiPhi'] = tenLoaiPhi;
    return data;
  }
}