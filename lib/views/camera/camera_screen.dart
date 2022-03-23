import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dymogo/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dymogo/main.dart';
import 'package:http/http.dart';

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
      ResolutionPreset.medium,
    );

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
              return _buildCameraPreview(
                  context, _cameraController, _initializeControllerFuture);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

Widget _buildCameraUX(context, _cameraController, _initializeControllerFuture) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      SvgPicture.asset(
        "assets/images/camera_screen/galerie.svg",
        width: 60,
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 8),
          borderRadius: BorderRadius.circular(60),
        ),
        child: GestureDetector(
          // Provide an onPressed callback.
          onTap: (() async {
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

              var response = uploadFileToServer(image.path);

              print(response);

              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    // Pass the automatically generated path to
                    // the DisplayPictureScreen widget.
                    // imagePath: image.path,
                    imagePath: image.path,
                  ),
                ),
              );
              // var image = "assets/images/map.png";
            } catch (e) {
              // If an error occurs, log the error to the console.
              // ignore: avoid_print
              print(e);
            }
          }),
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 33,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 28,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: (() => {}),
        child: SvgPicture.asset(
          "assets/images/camera_screen/flip.svg",
          width: 60,
        ),
      ),
    ]),
  );
}

Widget _buildCameraPreview(
    context, _cameraController, Future<void> initializeControllerFuture) {
  final size = MediaQuery.of(context).size;

  return Container(
    height: size.height,
    color: Colors.black,
    child: Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 50),
      child: Stack(children: [
        SizedBox(
          height: size.height,
          child: CameraPreview(
            _cameraController,
          ),
        ),
        Container(
          color: Colors.transparent,
          height: size.height,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/images/camera_screen/burger.svg",
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ],
              ),
            ),
            const Spacer(),
            _buildCameraUX(
                context, _cameraController, initializeControllerFuture)
          ]),
        ),
      ]),
    ),
  );
}

Future fetchStr() async {
  await Future.delayed(const Duration(seconds: 10), () {});
  return 'Hello World';
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  final Future str = fetchStr();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: str,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.file(File(imagePath));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return Stack(children: const [
              CircularProgressIndicator(),
            ]);
          },
        ),
      ),
    );
  }
}

Future uploadFileToServer(imagePath) async {
  var request = MultipartRequest(
    'POST',
    Uri.parse('http://localhost:8000/api/test/'),
  );
  request.files.add(
    await MultipartFile.fromPath('oui', imagePath),
  );
  Response response = await Response.fromStream(await request.send());

  print("Result: ${response.statusCode}");
  print("${response.body}");

  return response.body;
}
