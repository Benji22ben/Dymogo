import 'dart:convert';
import 'package:dymogo/constants.dart';
import 'package:dymogo/models/Report.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:jwt_decode/jwt_decode.dart';

class ReportService {
  static const String userUrl = baseUrl + 'user/get_report_by_user_uuid/';
  static const String imageUrl = baseUrl + 'user/get_image_report_by_uuid/';

  static Future<List<Report>> getReports() async {
    List<Report> reports = [];
    var token = await storage.read(key: 'token');

    var request = Request('GET', Uri.parse(userUrl + getUserUuid(token)));
    request.headers['Authorization'] = 'Bearer $token';

    var response = await request.send();

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      for (var report in data) {
        reports.add(Report.fromJson(report));
      }
    } else {
      print(response.statusCode);
    }
    reports.removeWhere((element) => element.type == 'autre');
    reports.removeWhere((element) => element.user_link != getUserUuid(token));

    return reports;
  }

  static getUserUuid(token) {
    if (token != '' || token != null) {
      var decodedToken = Jwt.parseJwt(token);
      print(decodedToken);
      return decodedToken['uuid'];
    } else {
      return null;
    }
  }

  // getImage from Report UUID
  static Future<Widget?> getImage(String reportUuid) async {
    var token = await storage.read(key: 'token');
    var request = Request('GET', Uri.parse(imageUrl + reportUuid));
    request.headers['Authorization'] = 'Bearer $token';

    var response = await request.send();

    if (response.statusCode == 200) {
      var image = await response.stream.bytesToString();
      var image_decoded = Image.memory(base64Decode(image.toString()));
      return Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: image_decoded.image, fit: BoxFit.fill),
        ),
      );
    } else {
      print("Erreur " + response.statusCode.toString());
      return Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withAlpha(50),
        ),
      );
    }
  }
}
