import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final report;
  const ReportCard({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            title: Text(
              report.id.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
