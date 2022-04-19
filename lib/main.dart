// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:dymogo/views/home/home_screen.dart';
import 'package:dymogo/views/utilities/locator.dart';

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
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgoundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
