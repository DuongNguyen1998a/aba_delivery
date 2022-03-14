class ExpenseAttachment {
  String attachName;
  String rowPointer;
  int id;

  ExpenseAttachment({
    required this.attachName,
    required this.rowPointer,
    required this.id,
  });

  factory ExpenseAttachment.fromJson(Map<String, dynamic> json) {
    return ExpenseAttachment(
      attachName: json['attachName'],
      rowPointer: json['rowPointer'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['attachName'] = attachName;
    data['rowPointer'] = rowPointer;
    data['id'] = id;
    return data;
  }
}
