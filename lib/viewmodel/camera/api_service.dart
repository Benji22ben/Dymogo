import 'dart:convert';

import 'package:http/http.dart';
import 'package:dymogo/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static const String apiEndpoint = baseUrl + 'create_report';

  static Future uploadFileToServer(
    String imagePath,
    String folderPicture,
    String latitude,
    String longitude,
  ) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    var request = MultipartRequest(
      'POST',
      Uri.parse(apiEndpoint),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await MultipartFile.fromPath("picture", imagePath));
    request.fields['folder_picture'] = folderPicture;
    request.fields['report'] = '{}';
    request.fields['location'] =
        '{ "latitude" : "' + latitude + '", "longitude" : ' + longitude + '}';
    var response = await request.send();
    print(response.headers);
    print(response.statusCode);
    return response;
  }
}
