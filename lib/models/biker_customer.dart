class BikerCustomer {
  int id;
  String? customerCode;
  String? customerName;

  BikerCustomer({
    required this.id,
    required this.customerCode,
    required this.customerName,
  });

  factory BikerCustomer.fromJson(Map<String, dynamic> json) {
    return BikerCustomer(
      id: json['id'],
      customerCode: json['customerCode'],
      customerName: json['customerName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customerCode'] = customerCode;
    data['customerName'] = customerName;
    return data;
  }
}
