import 'dart:io';

import 'package:dymogo/views/predictions/predictions_screen.dart';
import 'package:dymogo/viewmodel/camera/api_service.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class CameraService {
  takePicture(context, _initializeControllerFuture, _cameraController) async {
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

      var response = await classifyImage(image.path);

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

  Future classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 117.0, // defaults to 117.0
      imageStd: 1.0, // defaults to 1.0
      numResults: 5, // defaults to 5
      threshold: 0.1, // defaults to 0.1
      asynch: true, // defaults to true
    );

    print(output);
    return output;
  }
}
