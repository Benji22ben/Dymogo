import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dymogo/viewmodel/camera/ia_service.dart';
import 'package:dymogo/viewmodel/map/location_service.dart';
import 'package:dymogo/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:dymogo/constants.dart';
import 'package:dymogo/viewmodel/camera/api_service.dart';
import 'package:dymogo/views/utilities/authProtect.dart';
import 'package:dymogo/widgets/navigation_drawer_widget.dart';

class PredictionScreen extends StatelessWidget {
  final XFile image;
  final CameraController controller;

  const PredictionScreen(
      {Key? key, required this.image, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _cameraController = controller;

    return FutureBuilder(
      future: IAService.recognizeImageBinary(image),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(
            'There was an error :(',
          );
        } else if (snapshot.hasData) {
          var response = snapshot.data as dynamic;
          var label = response[0]['label'];
          if (label == 'graph') {
            label = 'Graffiti';
          }
          var number = response[0]['confidence'];
          final percent = (number * 100).round().toString();
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
            body: Stack(children: [
              Stack(children: [
                Image.file(File(image.path)),
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(35))),
                      width: 250,
                      height: 75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(capitalize(label)),
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: kPrimaryColor,
                        ),
                        child: TextButton(
                          onPressed: () async {
                            var locationData =
                                await LocationService().locationGet();
                            await _cameraController.dispose();
                            ApiService.uploadFileToServer(
                                    image.path,
                                    label,
                                    locationData.latitude.toString(),
                                    locationData.longitude.toString())
                                .then((value) async {
                              var isAuthenticated =
                                  await AuthProtect.isTokenValid();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomeScreen(
                                    authenticated: isAuthenticated,
                                  ),
                                ),
                              );
                            });
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => const CameraScreen(),
                            //   ),
                            // CameraService.closeCamera();
                            // );
                          },
                          child: const Text(
                            "Correct",
                            style:
                                TextStyle(fontSize: 18, color: kPrimaryColor),
                          ),
                        )),
                  ]),
                ),
              ),
            ]),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}
