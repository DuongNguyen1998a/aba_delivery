class FeeType {
  int id;
  String feeName;
  String abbreviations;

  FeeType({
    required this.id,
    required this.feeName,
    required this.abbreviations,
  });

  factory FeeType.fromJson(Map<String, dynamic> json) {
    return FeeType(
      id: json['id'],
      feeName: json['feeName'],
      abbreviations: json['abbreviations'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['feeName'] = feeName;
    data['abbreviations'] = abbreviations;
    return data;
  }
}
