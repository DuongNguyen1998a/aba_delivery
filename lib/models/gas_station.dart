class GasStation {
  int? gasStationId;
  String? gasStationName;
  double? lat;
  double? lng;

  GasStation({
    required this.gasStationId,
    required this.gasStationName,
    required this.lat,
    required this.lng,
  });

  factory GasStation.fromJson(Map<String, dynamic> json) {
    return GasStation(
      gasStationId: json['gasStationId'],
      gasStationName: json['gasStationName'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gasStationId'] = gasStationId;
    data['gasStationName'] = gasStationName;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
