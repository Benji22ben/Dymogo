import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dymogo/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  static const String apiEndpoint = baseUrl + 'user/createreport';

  static Future uploadFileToServer(
    String imagePath,
    String folderPicture,
    String latitude,
    String longitude,
  ) async {
    if (folderPicture == 'Graffiti' || folderPicture == 'graffiti') {
      folderPicture = 'graph';
    } else if (folderPicture == 'stationnement dangereux' ||
        folderPicture == 'Stationnement dangereux') {
      folderPicture = 'voiture';
    } else if (folderPicture == 'Déchets' || folderPicture == 'déchets') {
      folderPicture = 'dechet';
    } else if (folderPicture == "Bouche d'égouts" ||
        folderPicture == "bouche d'égouts") {
      folderPicture = "egout";
    }

    print(folderPicture);
    File imageCompressed = await compressAndGetFile(imagePath);

    var token = await storage.read(key: 'token');
    var request = MultipartRequest(
      'POST',
      Uri.parse(apiEndpoint),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.files
        .add(await MultipartFile.fromPath("picture", imageCompressed.path));
    request.fields['folder_picture'] = folderPicture.toLowerCase();
    request.fields['report'] = '{}';
    request.fields['location'] =
        '{ "latitude" : "' + latitude + '", "longitude" : ' + longitude + '}';
    var response = await request.send();
    print(await response.stream.toBytes().toString());
    print(response.statusCode);

    return response.statusCode;
  }

  static Future<File> compressAndGetFile(String imagePath) async {
    File file = File(imagePath);
    final dir = await getTemporaryDirectory();

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      dir.absolute.path + "/temp.jpg",
      quality: 40,
      rotate: 0,
    );

    print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }
}
