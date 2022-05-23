import 'dart:convert';

import 'package:http/http.dart';
import 'package:dymogo/constants.dart';

class SignIn {
  static const String apiEndpoint = baseUrl + 'login';

  static Future signIn(
    String email,
    String password,
  ) async {
    var request = Request('POST', Uri.parse(apiEndpoint));
    request.bodyFields = <String, String>{
      'email': email.replaceAll(' ', ''),
      'password': password.replaceAll(' ', '')
    };
    var response = await request.send();

    var token = response.statusCode == 200
        ? jsonDecode(await response.stream.bytesToString())['jwt']
        : null;

    return response.statusCode == 200 ? token : null;
  }
}
