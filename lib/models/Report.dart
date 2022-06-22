class Report {
  final String id;

  Report({
    required this.id,
  });

  static fromJson(Map<String, dynamic> json) {
    var report = Report(
      id: json['id'],
    );
    return report;
  }
}
