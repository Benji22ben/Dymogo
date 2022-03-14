import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class CameraViewModel extends ChangeNotifier {
  late List<CameraDescription> _cameras;
  late CameraController _controller;

  void setCameraController(CameraDescription description) {
    _controller = CameraController(description, ResolutionPreset.ultraHigh,
        enableAudio: true);
    _controller.initialize().then((_) {
      notifyListeners();
    });
  }

  void init() async {
    _cameras = await availableCameras();
    setCameraController(_cameras.first);
    notifyListeners();
  }

  reverseCam() {
    final lensDirection = _controller.description.lensDirection;
    _cameras.forEach((element) {
      if (element.lensDirection != lensDirection) {
        print('found ' + element.lensDirection.toString());

        setCameraController(element);

        return;
      }
    });
    print(lensDirection);
  }

  CameraController getController() => _controller;

  get allCameras => _cameras;
}
