class Report {
  final int id;
  final String type;

  Report({
    required this.id,
    required this.type,
  });

  static fromJson(Map<String, dynamic> json) {
    var report = Report(
      id: json['id'],
      type: json['type'],
    );
    return report;
  }
}
