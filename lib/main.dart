// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:dymogo/views/home/home_screen.dart';
import 'package:dymogo/views/utilities/locator.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setup();

  // Obtain a list of the available cameras on the device.
  cameras = await availableCameras();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dymogo',
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgoundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/images/Dymogo.png'),
        ],
      ),
      backgroundColor: kPrimaryColor,
      nextScreen: const HomeScreen(),
      splashIconSize: 103,
      duration: 2000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      //transitionDuration: const Duration(seconds: 1),
      animationDuration: const Duration(seconds: 1),
    );
  }
}
