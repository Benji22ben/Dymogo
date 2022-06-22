import 'dart:convert';
import 'package:dymogo/constants.dart';
import 'package:dymogo/models/Report.dart';
import 'package:http/http.dart';
import 'package:jwt_decode/jwt_decode.dart';

class ReportService {
  static const String apiEndpoint = baseUrl + 'user/get_report_by_user_uuid/';

  static Future<List<Report>> getReports() async {
    List<Report> reports = [];
    var token = await storage.read(key: 'token');
    var request = Request('GET', Uri.parse(apiEndpoint + getUserUuid(token)));
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
}
