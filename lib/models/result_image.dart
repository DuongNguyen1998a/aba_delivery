class ResultImage {
  String rowPointer;
  String id;
  String atmBuyshipment;
  String documentType;
  String attachName;
  String attachment;

  ResultImage({
    required this.rowPointer,
    required this.id,
    required this.atmBuyshipment,
    required this.documentType,
    required this.attachName,
    required this.attachment,
  });

  factory ResultImage.fromJson(Map<String, dynamic> json) {
    return ResultImage(
      rowPointer: json['rowPointer'],
      id: json['id'],
      atmBuyshipment: json['atmBuyshipment'],
      documentType: json['documentType'],
      attachName: json['attachName'],
      attachment: json['attachment'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['rowPointer'] = rowPointer;
    data['id'] = id;
    data['atmBuyshipment'] = atmBuyshipment;
    data['documentType'] = documentType;
    data['attachName'] = attachName;
    data['attachment'] = attachment;
    return data;
  }
}
