import 'package:dymogo/models/Report.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final Report report;
  const ReportCard({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0.0,
      child: Row(
        children: [
          Text(
            report.type,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
