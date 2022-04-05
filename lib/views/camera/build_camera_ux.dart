import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dymogo/views/predictions/predictions_screen.dart';
import 'package:dymogo/viewmodel/camera/api_service.dart';
import 'package:dymogo/viewmodel/camera/picture_service.dart';

Widget buildCameraUX(context, _cameraController, _initializeControllerFuture) {
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
          onTap: (PictureService.takePicture(context, _initializeControllerFuture, _cameraController)),
          // onTap: (() async {
          //   // Take the Picture in a try / catch block. If anything goes wrong,
          //   // catch the error.
          //   try {
          //     // Ensure that the camera is initialized.
          //     await _initializeControllerFuture;

          //     // Attempt to take a picture and then get the location
          //     // where the image file is saved.

          //     final image = await _cameraController.takePicture();
          //     // const image = "assets/images/photoExemple.png";

          //     print("IMAGE PRISE");

          //     var response = await ApiService.uploadFileToServer(image.path);

          //     await Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => PredictionScreen(
          //           response: response,
          //           imagePath: image.path,
          //         ),
          //       ),
          //     );
          //   } catch (e) {
          //     print(e);
          //   }
          // }
          ),
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
