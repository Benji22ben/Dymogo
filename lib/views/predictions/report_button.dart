import 'package:camera/camera.dart';
import 'package:dymogo/constants.dart';
import 'package:dymogo/viewmodel/camera/api_service.dart';
import 'package:dymogo/views/home/home_screen.dart';
import 'package:dymogo/views/utilities/authProtect.dart';
import 'package:flutter/material.dart';

import '../../viewmodel/map/location_service.dart';

class ReportButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    print(label);

    return Container(
        width: size.width - 50,
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
            var locationData = await LocationService.locationGet();
            await cameraController.dispose();
            print(label);
            ApiService.uploadFileToServer(
                    image.path,
                    label,
                    locationData.latitude.toString(),
                    locationData.longitude.toString())
                .then((statusCode) async {
              if (statusCode == 200 || statusCode == 201) {
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
          child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ));
  }
}
