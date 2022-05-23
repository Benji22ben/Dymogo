import 'dart:convert';

import 'package:http/http.dart';
import 'package:dymogo/constants.dart';

class LoginViewModel {
  static const String apiEndpoint = baseUrl + 'login';

  static Future login(
    String email,
    String password,
  ) async {
    var request = Request('POST', Uri.parse(apiEndpoint));
    request.headers['Content-Type'] =
        'application/x-www-form-urlencoded; charset=UTF-8';
    request.bodyFields = <String, String>{
      'email': email,
      'password': password,
    };

    print(request);

    var response = await request.send();

    var token = jsonDecode(await response.stream.bytesToString())['jwt'];

    return response.statusCode == 200 ? token : null;
  }
}
