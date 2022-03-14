class BasketResponse {
  int id;
  int? quantity;
  int? quantityConfirmSendStore;
  int? quantityConfirmReceivedStore;
  int? quantityAfter;
  String basketName;

  BasketResponse({
    required this.id,
    required this.quantity,
    required this.quantityConfirmSendStore,
    required this.quantityConfirmReceivedStore,
    required this.quantityAfter,
    required this.basketName,
  });

  factory BasketResponse.fromJson(Map<String, dynamic> json) {
    return BasketResponse(
      id: json['id'],
      quantity: json['quantity'],
      quantityConfirmSendStore: json['quantityConfirmSendStore'],
      quantityConfirmReceivedStore: json['quantityConfirmReceivedStore'],
      quantityAfter: json['quantityAfter'],
      basketName: json['basketName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['quantityConfirmSendStore'] = quantityConfirmSendStore;
    data['quantityConfirmReceivedStore'] = quantityConfirmReceivedStore;
    data['quantityAfter'] = quantityAfter;
    data['basketName'] = basketName;
    return data;
  }
}
