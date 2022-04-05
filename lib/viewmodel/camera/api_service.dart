import 'package:http/http.dart';
import 'dart:convert';

class ApiService {
  static const String apiEndpoint = 'http://localhost:8000/api/reports/';

  static Future uploadFileToServer(imagePath) async {
    var request = MultipartRequest(
      'POST',
      Uri.parse(apiEndpoint),
    );
    request.files.add(
      await MultipartFile.fromPath('image', imagePath),
    );
    Response response = await Response.fromStream(await request.send());

    print("Result: ${response.statusCode}");

    final percent = jsonDecode(response.body);

    // final _result = percent[0];
    // final label = percent[0]['label'];
    // final pourcent = percent[0]['percent'];

    // final _result = result.substring(1, 4);
    // print(_result);
    // print(label);
    // print(pourcent);

    return percent;
  }
}
