import 'package:camera/camera.dart';
import 'package:dymogo/views/utilities/camera_header_bar.dart';

import 'package:flutter/material.dart';
import 'build_camera_ux.dart';
import 'package:dymogo/size_config.dart';

Widget buildCameraPreview(
    context, _cameraController, Future<void> initializeControllerFuture) {
  final height = SizeConfig.screenHeight;
  return Container(
    height: height,
    color: Colors.black,
    child: Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 50),
      child: Stack(children: [
        SizedBox(
          height: height,
          child: CameraPreview(
            _cameraController,
          ),
        ),
        Container(
          color: Colors.transparent,
          height: height,
          child: Column(children: [
            const CameraHeaderBar(
                top: 25, color: Color.fromARGB(255, 255, 255, 255)),
            const Spacer(),
            buildCameraUX(
                context, _cameraController, initializeControllerFuture)
          ]),
        ),
      ]),
    ),
  );
}
