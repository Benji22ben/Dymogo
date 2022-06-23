import 'dart:convert';
import 'package:dymogo/constants.dart';
import 'package:dymogo/models/Report.dart';
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
    print(reports);

    return reports;
  }

  static getUserUuid(token) {
    var decodedToken = Jwt.parseJwt(token);
    print(decodedToken);

    return decodedToken['uuid'];
  }

  // getImage from Report UUID
  static Future<String> getImage(String reportUuid) async {
    var token = await storage.read(key: 'token');
    var request = Request('GET', Uri.parse(imageUrl + reportUuid));
    request.headers['Authorization'] = 'Bearer $token';

    var response = await request.send();

    if (response.statusCode == 200) {
      var img = await response.stream.bytesToString();
      return img;
    } else {
      print(response.statusCode);
      throw Exception('Failed to get image');
    }
  }
}
