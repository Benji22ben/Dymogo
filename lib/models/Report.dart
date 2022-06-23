class Report {
  final int id;
  final String type;
  final String status;
  final String uuid;
  final String user_link;
  final DateTime date;

  Report({
    required this.id,
    required this.type,
    required this.status,
    required this.user_link,
    required this.uuid,
    required this.date,
  });

  static fromJson(Map<String, dynamic> json) {
    var report = Report(
      id: json['id'],
      type: json['type'],
      status: json['status'],
      uuid: json['uuid'],
      user_link: json['user_link'],
      date: DateTime.parse(json['created']),
    );
    return report;
  }
}
