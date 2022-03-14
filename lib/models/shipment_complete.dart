class ShipmentComplete {
  String failedTrip;
  String totalTrip;
  String dropCompleted;
  String totalDrop;

  ShipmentComplete({
    required this.failedTrip,
    required this.totalTrip,
    required this.dropCompleted,
    required this.totalDrop,
  });

  factory ShipmentComplete.fromJson(Map<String, dynamic> json) {
    return ShipmentComplete(
      failedTrip: json['failedTrip'],
      totalTrip: json['totalTrip'],
      dropCompleted: json['dropCompleted'],
      totalDrop: json['totalDrop'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['failedTrip'] = failedTrip;
    data['totalTrip'] = totalTrip;
    data['dropCompleted'] = dropCompleted;
    data['totalDrop'] = totalDrop;
    return data;
  }
}
