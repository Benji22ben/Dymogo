import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';

class IAService {
  Future loadModel() async {
    Tflite.close();
    try {
      String? res = await Tflite.loadModel(
        model: "assets/dymogo_ia_tflite/saved_model.tflite",
        labels: "assets/dymogo_ia_tflite/lables.txt",
      );
      print(res);
    } on PlatformException {
      print('Failed to load model.');
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

    return output;
  }
}
