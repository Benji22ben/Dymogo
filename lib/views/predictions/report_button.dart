import 'package:camera/camera.dart';
import 'package:dymogo/constants.dart';
import 'package:dymogo/viewmodel/camera/api_service.dart';
import 'package:dymogo/viewmodel/camera/camera_service.dart';
import 'package:dymogo/views/home/home_screen.dart';
import 'package:dymogo/views/utilities/authProtect.dart';
import 'package:flutter/material.dart';

import '../../viewmodel/map/location_service.dart';

class ReportButton extends StatefulWidget {
  final cameraController;

  final size;

  final XFile image;

  final String label;

  final String text;

  const ReportButton({
    Key? key,
    required this.cameraController,
    required this.size,
    required this.image,
    required this.label,
    required this.text,
  }) : super(key: key);

  @override
  State<ReportButton> createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print(lowerCase(widget.label));

    return Container(
        width: widget.size.width - 50,
        height: 70,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          gradient:
              const LinearGradient(colors: [kPrimaryColor, kSecondaryColor]),
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: kPrimaryColor,
        ),
        child: TextButton(
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            var locationData = await LocationService.locationGet();
            await widget.cameraController.dispose();
            ApiService.uploadFileToServer(
                    widget.image.path,
                    lowerCase(widget.label),
                    locationData.latitude.toString(),
                    locationData.longitude.toString())
                .then((statusCode) async {
              if (statusCode == 200 || statusCode == 201) {
                await CameraService.closeCamera(widget.cameraController);
                AuthProtect.isTokenValid().then((isAuthenticated) async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeScreen(
                        authenticated: isAuthenticated,
                      ),
                    ),
                  );
                });
              }
            });
          },
          child: isLoading
              ? Row(children: [
                  Text(
                    "Reporting...",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(left: 10),
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white))),
                ])
              : Text(
                  widget.text,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
        ));
  }
}

String lowerCase(String string) {
  if (string.isEmpty) {
    return string;
  }

  return string[0].toLowerCase() + string.substring(1);
}
