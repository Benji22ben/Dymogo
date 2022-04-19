import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dymogo/views/predictions/predictions_screen.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;

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
      var response = await recognizeImageBinary(image);

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

  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Future recognizeImageBinary(XFile image) async {
    await Tflite.loadModel(
      model: "assets/dymogo_ia_tflite/saved_model.tflite",
      labels: "assets/dymogo_ia_tflite/labels.txt",
    );

    int startTime = DateTime.now().millisecondsSinceEpoch;

    img.Image? oriImage = img.decodeJpg(await image.readAsBytes());

    img.Image resizedImage = img.copyResizeCropSquare(oriImage!, 224);

    var output = await Tflite.runModelOnBinary(
      binary: imageToByteListFloat32(resizedImage, 224, 127.5, 127.5),
      numResults: 3,
      threshold: 0.05,
    );

    Tflite.close();
    int endTime = DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
    print(output);
    return output;
  }
}
