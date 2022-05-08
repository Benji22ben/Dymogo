import 'package:dymogo/viewmodel/camera/camera_service.dart';
import 'package:dymogo/views/utilities/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildCameraUX(
    context, _cameraController, _initializeControllerFuture, _cameraOn) {
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
          onTap: (() async => {
                await getIt<CameraService>().takePicture(context,
                    _initializeControllerFuture, _cameraController, _cameraOn),
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
