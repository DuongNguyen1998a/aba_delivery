class Problem {
  int rowId;
  String title;
  Null created;
  Null createdBy;
  Null modified;
  Null modifiedBy;

  Problem({required this.rowId, required this.title, required this.created, required this.createdBy, required this.modified, required this.modifiedBy});

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      rowId: json['rowId'],
      title: json['title'],
      created:   json['created']  ,
      createdBy: json['createdBy']  ,
      modified:  json['modified']  ,
      modifiedBy:json['modifiedBy']  ,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['rowId'] = rowId;
    data['title'] = title;
    data['created'] = created;
    data['createdBy'] = createdBy;
    data['modified'] = modified;
    data['modifiedBy'] = modifiedBy;
    return data;
  }
}
