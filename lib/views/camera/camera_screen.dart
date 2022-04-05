import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dymogo/main.dart';
import 'package:dymogo/views/camera/build_camera_preview.dart';
import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      // Get a specific camera from the list of available cameras.
      cameras.first,
      // Define the resolution to use.
      ResolutionPreset.ultraHigh,
    );

    loadModel();

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return buildCameraPreview(
                  context, _cameraController, _initializeControllerFuture);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

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
