import 'package:http/http.dart';
import 'dart:convert';

class ApiService {
  static const String apiEndpoint = 'http://localhost:8000/api/reports/';

  static Future uploadFileToServer(
    String imagePath,
    String folderPicture,
    String latitude,
    String longitude,
  ) async {
    var request = MultipartRequest(
      'POST',
      Uri.parse(apiEndpoint),
    );
    request.files.add(await MultipartFile.fromPath("picture", imagePath));
    request.fields['folder_picture'] = folderPicture;
    request.fields['report'];
    request.fields['location'] =
        '{ "latitude" : "' + latitude + '", "longitude" : ' + longitude + '}';

    var response = await request.send();

    print("Result: ${response.statusCode}");
  }
}
