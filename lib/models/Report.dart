class Report {
  final int id;
  final String type;
  final String status;
  final String uuid;
  final DateTime date;

  Report({
    required this.id,
    required this.type,
    required this.status,
    required this.uuid,
    required this.date,
  });

  static fromJson(Map<String, dynamic> json) {
    var report = Report(
      id: json['id'],
      type: json['type'],
      status: json['status'],
      uuid: json['uuid'],
      date: DateTime.parse(json['created']),
    );
    return report;
  }
}
