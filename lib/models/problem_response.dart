class ProblemResponse {
  int? id;
  String? message;

  ProblemResponse({required this.id, required this.message});

  factory ProblemResponse.fromJson(Map<String, dynamic> json) {
    return ProblemResponse(
      id: json['id'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    return data;
  }
}
