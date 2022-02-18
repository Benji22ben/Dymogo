// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'size_config.dart';

void main() {
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
          textTheme: GoogleFonts.robotoCondensedTextTheme(
            Theme.of(context).textTheme,
          )),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final urlimg = 'assets/images/map.png';

    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(urlimg), fit: BoxFit.cover)),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -30.0, 0.0),
          child: Align(
            alignment: Alignment.center,
            child: ColumnSuper(
              innerDistance: -105,
              invert: true,
              children: [
                Container(
                  child: SimpleShadow(
                    opacity: 0.25,
                    offset: Offset(0, 1),
                    color: Color(0xA6A6A640),
                    sigma: 10,
                    child: SvgPicture.asset(
                      "assets/images/logo.svg",
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth! * 0.80,
                  height: SizeConfig.screenHeight! * 0.65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(214, 212, 212, 0.25),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ]),
                  child: Column(
                    children: [
                      Container(
                        height: 95,
                        width: 100,
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Text(
                            "WELCOME",
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.blue,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
