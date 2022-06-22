import 'package:dymogo/constants.dart';
import 'package:dymogo/viewmodel/reports/report_service.dart';
import 'package:dymogo/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dymogo/views/reports/report_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
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
      body: SingleChildScrollView(
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          color: Colors.white,
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                // Container(
                //   height: screenHeight * 0.75,
                //   width: screenWidth,
                //   color: Colors.white,
                //   child: Container(
                //     margin: EdgeInsets.only(top: screenHeight * 0.15, left: 25),
                //     child: Text(
                //       'Recents Reports',
                //       style: TextStyle(color: kDarkTextColor, fontSize: 20),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 40),
                  child: Text(
                    'Recents Reports',
                    style: TextStyle(color: kDarkTextColor, fontSize: 20),
                  ),
                ),
                FutureBuilder(
                  future: ReportService.getReports(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var reports = snapshot.data;

                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: reports.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: ReportCard(
                                  report: reports[index],
                                ));
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: screenHeight * 0.20,
                  width: screenWidth * 0.8,
                  margin: EdgeInsets.only(top: 100),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: RadialGradient(
                      center: Alignment.topLeft,
                      radius: 3,
                      colors: [
                        Color(0xFFB1F3E6),
                        kGradientColor2,
                        kGradientColor3,
                        Color(0xFF98FAE6),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/images/logo_report.svg",
                            width: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              "Total Reports",
                              style: TextStyle(
                                color: kDarkTextColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, left: 60),
                            child: Text("Dymogo",
                                style: TextStyle(
                                  color: kDarkTextColor,
                                  fontSize: 15,
                                )),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: FutureBuilder(
                              future: ReportService.getReports(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                      snapshot.data.length.toString() +
                                          " reports",
                                      style: TextStyle(
                                          color: kDarkTextColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold));
                                } else {
                                  return Text('0',
                                      style: TextStyle(
                                          color: kDarkTextColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold));
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}