import 'package:dymogo/constants.dart';
import 'package:dymogo/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
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
        Container(
          color: Colors.blue,
          height: screenHeight,
          width: screenWidth,
          margin: EdgeInsets.only(top: 300),
        ),
        Column(
          children: [
            Container(
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    kPrimaryColor,
                    kGradientColor,
                  ],
                ),
              ),
            ),
            Container(
              height: screenHeight * 0.75,
              color: Colors.white,
            )
          ],
        ),
      ]),
    );
  }
}
