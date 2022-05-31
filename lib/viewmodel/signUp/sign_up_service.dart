import 'dart:convert';

import 'package:http/http.dart';
import 'package:dymogo/constants.dart';

class SignUp {
  static const String apiEndpoint = baseUrl + 'register';

  static Future signUp(
    String username,
    String email,
    String password,
  ) async {
    var request = Request('POST', Uri.parse(apiEndpoint));
    request.headers['Content-Type'] = 'application/json';

    request.body = jsonEncode(<String, String>{
      'name': username.replaceAll(' ', ''),
      'email': email.replaceAll(' ', ''),
      'password': password.replaceAll(' ', '')
    });

    var response = await request.send();

    return response.statusCode;
  }
}
