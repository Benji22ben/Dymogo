import 'package:camera/camera.dart';
import 'package:dymogo/views/utilities/camera_header_bar.dart';
import 'package:flutter/material.dart';
import 'build_camera_ux.dart';

Widget buildCameraPreview(context, _cameraController,
    Future<void> initializeControllerFuture, _cameraOn) {
  var screenHeight = MediaQuery.of(context).size.height;
  final height = screenHeight;
  return Container(
    height: height,
    color: Colors.black,
    child: Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 50),
      child: Stack(children: [
        SizedBox(
          height: height,
          // If camera is On then show the camera preview else keep memory showing a container
          child: _cameraOn
              ? CameraPreview(
                  _cameraController,
                )
              : Container(),
        ),
        Container(
          color: Colors.transparent,
          height: height,
          child: Column(children: [
            const CameraHeaderBar(
                top: 25,
                color: Color.fromARGB(255, 255, 255, 255),
                toPage: "none"),
            const Spacer(),
            buildCameraUX(context, _cameraController,
                initializeControllerFuture, _cameraOn)
          ]),
        ),
      ]),
    ),
  );
}
