import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dymogo/views/utilities/camera_header_bar.dart';
import 'package:dymogo/constants.dart';

class PredictionScreen extends StatelessWidget {
  final String imagePath;
  final Map response;

  const PredictionScreen(
      {Key? key, required this.imagePath, required this.response})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var label = response[0]['label'];
    if (label == 'graph') {
      label = 'Graffiti';
    }
    final percent = response[0]['percent'].toString();
    return Scaffold(
      body: Stack(children: [
        Stack(children: [
          Image.file(File(imagePath)),
          const CameraHeaderBar(
              top: 25, color: Color.fromARGB(255, 255, 255, 255)),
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

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}
