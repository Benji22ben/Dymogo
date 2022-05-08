import 'package:camera/camera.dart';
import 'package:dymogo/views/predictions/predictions_screen.dart';
import 'package:flutter/material.dart';

class CameraService {
  takePicture(context, _initializeControllerFuture, _cameraController,
      _cameraOn) async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;
      _cameraController.setFlashMode(FlashMode.off);

      // Attempt to take a picture
      final image = await _cameraController.takePicture();

      print("Picture Taken");

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PredictionScreen(
            image: image,
            controller: _cameraController,
          ),
        ),
      );
      _cameraOn = false;
    } catch (e) {
      return AlertDialog(
        title: const Text('Camera Failure'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('There is an error with the camera'),
            ],
          ),
        ),
      );
    }
  }

  Future closeCamera(CameraController _cameraController) async {
    if (_cameraController.value.isStreamingImages) {
      await _cameraController.stopImageStream();
    }
    await _cameraController.dispose();
  }
}
