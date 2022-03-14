class License {
  int id;
  String atmShipmentID;
  String? fullName;
  String customer;
  String startTime;
  String? driverId;
  String dateOfFiling;
  String? reason;
  String created;
  String statusManager;
  String? managerApprovedName;
  String? timeManagerResponse;
  String? noteFromManage;

  License({
    required this.id,
    required this.atmShipmentID,
    required this.fullName,
    required this.customer,
    required this.startTime,
    required this.driverId,
    required this.dateOfFiling,
    required this.reason,
    required this.created,
    required this.statusManager,
    required this.managerApprovedName,
    required this.timeManagerResponse,
    required this.noteFromManage,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      id: json['id'],
      atmShipmentID: json['atmShipmentID'],
      fullName: json['fullName'],
      customer: json['customer'],
      startTime: json['startTime'],
      driverId: json['driverId'],
      dateOfFiling: json['dateOfFiling'] ?? '2022-01-01',
      reason: json['reason'],
      created: json['created'],
      statusManager: json['statusManager'],
      managerApprovedName: json['managerApprovedName'],
      timeManagerResponse: json['timeManagerResponse'],
      noteFromManage: json['noteFromManage'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['atmShipmentID'] = atmShipmentID;
    data['fullName'] = fullName;
    data['customer'] = customer;
    data['startTime'] = startTime;
    data['driverId'] = driverId;
    data['dateOfFiling'] = dateOfFiling;
    data['reason'] = reason;
    data['created'] = created;
    data['statusManager'] = statusManager;
    data['managerApprovedName'] = managerApprovedName;
    data['timeManagerResponse'] = timeManagerResponse;
    data['noteFromManage'] = noteFromManage;
    return data;
  }
}
