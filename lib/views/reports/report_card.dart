import 'package:dymogo/models/Report.dart';
import 'package:dymogo/viewmodel/reports/report_service.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final Report report;
  const ReportCard({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String type = report.type;
    if (type == 'graph') {
      type = 'Graffiti';
    } else if (type == 'voiture') {
      type = 'Parking dangereux';
    } else if (type == 'dechet') {
      type = 'Déchets';
    } else if (type == 'egout') {
      type = "Bouche d'égouts";
    }
    return Card(
      color: Colors.white,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0.0,
      child: Row(
        children: [
          FutureBuilder(
            future: ReportService.getImage(report.uuid),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Text(
                  'There was an error :(',
                );
              } else if (snapshot.hasData) {
                Widget container = snapshot.data;
                return container;
              } else {
                return Container(
                  width: 60,
                  height: 60,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withAlpha(50),
                  ),
                  child: Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white))),
                );
              }
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capitalize(type),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                capitalize(report.status),
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          Spacer(),
          report.date.day == date.day && report.date.month == date.month ||
                  report.date.day == date.day - 1 &&
                      report.date.month == date.month &&
                      report.date.hour > date.hour
              ? Text(
                  'Today',
                  style: TextStyle(fontSize: 15),
                )
              : Text(
                  report.date.day.toString() +
                      '/' +
                      report.date.month.toString() +
                      '/' +
                      report.date.year.toString(),
                  style: TextStyle(fontSize: 15),
                )
        ],
      ),
    );
  }
}

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}
