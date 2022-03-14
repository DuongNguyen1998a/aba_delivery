class Feedback {
  int id;
  String? driverName;
  String? driverID;
  String? atmShipmentID;
  String? type;
  String title;
  String content;
  String createDate;

  Feedback({
    required this.id,
    required this.driverName,
    required this.driverID,
    required this.atmShipmentID,
    required this.type,
    required this.title,
    required this.content,
    required this.createDate,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      id: json['id'],
      driverName: json['driverName'],
      driverID: json['driverID'],
      atmShipmentID: json['atmShipmentID'],
      type: json['type'],
      title: json['title'],
      content: json['content'],
      createDate: json['createDate'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['driverName'] = driverName;
    data['driverID'] = driverID;
    data['atmShipmentID'] = atmShipmentID;
    data['type'] = type;
    data['title'] = title;
    data['content'] = content;
    data['createDate'] = createDate;
    return data;
  }
}
