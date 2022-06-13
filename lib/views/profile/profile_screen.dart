import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dymogo/widgets/navigation_drawer_widget.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Screen',
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromARGB(255, 108, 108, 108)),
          leading: GestureDetector(
            onTap: () => {
              Navigator.pop(context),
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Color.fromARGB(255, 108, 108, 108),
            ),
          ),
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfilePictureSection(),
              IllustrationSection(),
              TotalReportsSection(),
              AboutMeSection(),
              DetailsSection(),
              GraphSection(),
              GraphDetailSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePictureSection extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Color.fromARGB(255, 246, 246, 246),
      margin: EdgeInsets.only(top: 90),
      child: Column(children: [
        CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(
                "https://gauthier-mauche.fr/IMAGES/Mauche%20Gauthier.jpg")),
        SizedBox(height: 15),
        Text(
          'Gauthier Mauche',
          style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 78, 102, 97),
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Etudiant',
          style:
              TextStyle(fontSize: 14, color: Color.fromARGB(192, 78, 102, 97)),
        ),
      ]),
    );
  }
}

class IllustrationSection extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -80.0, 0.0),
      //color: Colors.red,
      child: Image.asset("assets/images/profile_screen/IllustrationBG.png"),
    );
  }
}

class TotalReportsSection extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        transform: Matrix4.translationValues(0.0, -60.0, 0.0),
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 98, 216, 192),
          //border: Border.all(width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 238, 238, 238),
              blurRadius: 0.0,
              offset: Offset(
                3.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          children: [
            SizedBox(width: 25),
            Text(
              '05',
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(4.0, 2.0),
                    blurRadius: 0.0,
                    color: Color.fromARGB(255, 78, 255, 219),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Text(
              'TOTAL\nREPORTS',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 50),
            Image.asset("assets/images/profile_screen/Coin.png"),
            SizedBox(width: 7),
            RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "550\n",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                TextSpan(
                  text: "POINTS",
                  style: TextStyle(
                      color: Color.fromARGB(255, 28, 126, 106),
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            SizedBox(width: 40),
            Image.asset("assets/images/profile_screen/Next.png"),
          ],
        ));
  }
}

class AboutMeSection extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -35.0, 0.0),
      height: 90,
      child: Row(
        children: [
          SizedBox(width: 40),
          Text(
            'About\nMe',
            style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 78, 102, 97),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          SizedBox(width: 10),
          VerticalDivider(
            thickness: 1.5,
            color: Color.fromARGB(255, 176, 176, 176),
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(width: 10),
          Flexible(
            child: new Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce rhoncus tincidunt eros, ac laoreet nulla efficitur et. Nam accumsan varius nibh,',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 149, 149, 149),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(width: 45),
        ],
      ),
    );
  }
}

class DetailsSection extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -35.0, 0.0),
      height: 110,
      child: Row(
        children: [
          SizedBox(width: 30),
          Text(
            'Details',
            style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 78, 102, 97),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          SizedBox(width: 10),
          VerticalDivider(
            thickness: 1.5,
            color: Color.fromARGB(255, 176, 176, 176),
            indent: 20,
            endIndent: 20,
          ),
          // Column(
          //   children: [
          //     Text(
          //       'Mauche Gauthier',
          //       style: TextStyle(
          //         fontSize: 12,
          //         color: Color.fromARGB(255, 149, 149, 149),
          //       ),
          //       textAlign: TextAlign.left,
          //     ),
          //     Text(
          //       'Annecy, France',
          //       style: TextStyle(
          //         fontSize: 12,
          //         color: Color.fromARGB(255, 149, 149, 149),
          //       ),
          //       textAlign: TextAlign.left,
          //     ),
          //     Text(
          //       'Etudiant',
          //       style: TextStyle(
          //         fontSize: 12,
          //         color: Color.fromARGB(255, 149, 149, 149),
          //       ),
          //       textAlign: TextAlign.left,
          //     ),
          //   ],
          // ),

          SizedBox(width: 45),
        ],
      ),
    );
  }
}

class GraphSection extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      color: Color.fromARGB(255, 196, 118, 154),
    );
  }
}

class GraphDetailSection extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.yellow,
    );
  }
}
