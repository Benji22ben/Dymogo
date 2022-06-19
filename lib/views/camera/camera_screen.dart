import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dymogo/main.dart';
import 'package:dymogo/views/camera/build_camera_preview.dart';
import 'package:dymogo/widgets/navigation_drawer_widget.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();

  void initState() {}
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  late int selectedCameraIndex;

  @override
  void initState() {
    super.initState();

    if (cameras.length > 0) {
      selectedCameraIndex = 0;
    } else {
      print('No camera available');
    }

    _cameraController = CameraController(
      // Get a specific camera from the list of available cameras.
      cameras[selectedCameraIndex],
      // Define the resolution to use.
      ResolutionPreset.ultraHigh,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
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
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => {
              Navigator.pop(context),
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            var _cameraOn = true;

            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return buildCameraPreview(context, _cameraController,
                  _initializeControllerFuture, _cameraOn);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
            }
          },
        ));
  }
}
