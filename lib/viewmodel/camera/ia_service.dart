import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

class IAService {
  static Uint8List imageToByteListFloat32(
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

  static Future recognizeImageBinary(XFile image) async {
    // Tflite.close();
    // try {
    String? res = await Tflite.loadModel(
      labels: "assets/dymogo_ia_tflite/labels.txt",
      model: "assets/dymogo_ia_tflite/saved_model.tflite",
    );

    print(res);
    // } on PlatformException {
    //   print('Failed to load model.');
    //   return const AlertDialog(semanticLabel: 'Failed To load Model.');
    // }

    img.Image? oriImage = img.decodeJpg(await image.readAsBytes());
    img.Image resizedImage = img.copyResizeCropSquare(oriImage!, 224);

    var output = await Tflite.runModelOnBinary(
      binary: imageToByteListFloat32(resizedImage, 224, 127.5, 127.5),
      numResults: 3,
      threshold: 0.05,
    );

    Tflite.close();

    // TODO : Delete this
    // Print model prediction
    print(output);

    return output;
  }
}
