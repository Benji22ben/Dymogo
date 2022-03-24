import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:camera/camera.dart';
import 'package:dymogo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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

              var response = await uploadFileToServer(image.path);

              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    response: response,
                    imagePath: image.path,
                  ),
                ),
              );
            } catch (e) {
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

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final response;

  DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.response})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final label = response[0]['label'];
    final percent = response[0]['percent'].toString();
    return Scaffold(
      body: Stack(children: [
        Stack(children: [
          Image.file(File(imagePath)),
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
          Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(35))),
                width: 250,
                height: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      capitalize(label),
                    ),
                    Text(percent + '%'),
                  ],
                )),
          ),
        ]),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/prediction_screen/background.png'),
                    fit: BoxFit.cover),
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            height: size.height * (40 / 100),
            width: size.width,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: const Text(
                  "Is that correct ?",
                  style: TextStyle(
                    color: kDarkTextColor,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                  width: size.width - 50,
                  height: 70,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [kPrimaryColor, kSecondaryColor]),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: kPrimaryColor,
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const CameraScreen(),
                      //   ),
                      // );
                    },
                    child: const Text(
                      "It’s perfect !",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )),
              Container(
                  width: size.width - 50,
                  height: 70,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const CameraScreen(),
                      //   ),
                      // );
                    },
                    child: const Text(
                      "I want to correct",
                      style: TextStyle(fontSize: 18, color: kPrimaryColor),
                    ),
                  )),
            ]),
          ),
        ),
      ]),
    );
  }
}

Future uploadFileToServer(imagePath) async {
  var request = MultipartRequest(
    'POST',
    Uri.parse('http://localhost:8000/api/reports/'),
  );
  request.files.add(
    await MultipartFile.fromPath('image', imagePath),
  );
  Response response = await Response.fromStream(await request.send());

  print("Result: ${response.statusCode}");

  final percent = jsonDecode(response.body);

  final _result = percent[0];
  final label = percent[0]['label'];
  final pourcent = percent[0]['percent'];

  // final _result = result.substring(1, 4);
  print(_result);
  print(label);
  print(pourcent);

  return percent;
}

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}
