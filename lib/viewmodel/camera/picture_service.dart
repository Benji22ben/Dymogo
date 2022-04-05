import 'package:dymogo/views/predictions/predictions_screen.dart';
import 'package:dymogo/viewmodel/camera/api_service.dart';
import 'package:flutter/material.dart';

class PictureService {
  static takePicture(
      context, _initializeControllerFuture, _cameraController) async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and then get the location
      // where the image file is saved.

      final image = await _cameraController.takePicture();
      // const image = "assets/images/photoExemple.png";

      print("IMAGE PRISE");

      var response = await ApiService.uploadFileToServer(image.path);

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PredictionScreen(
            response: response,
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
