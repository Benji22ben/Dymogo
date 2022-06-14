import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:dymogo/viewmodel/camera/ia_service.dart';
import 'package:dymogo/views/map/map_screen.dart';
import 'package:dymogo/views/predictions/report_button.dart';
import 'package:flutter/material.dart';
import 'package:dymogo/constants.dart';
import 'package:dymogo/widgets/navigation_drawer_widget.dart';
import 'package:dymogo/views/predictions/prediction_block.dart';

class PredictionScreen extends StatefulWidget {
  final XFile image;
  final CameraController controller;

  const PredictionScreen(
      {Key? key, required this.image, required this.controller})
      : super(key: key);

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  bool label_changed = false;
  String label = "";
  String percent = '';

  // List of items in our dropdown menu
  // FR
  // var items = [
  //   'Egout',
  //   'Dechet',
  //   'Graffiti',
  //   'Voiture',
  // ];

  // EN
  var items = [
    'Sewer',
    'Garbage',
    'Graffiti',
    'Car',
  ];

  var randomNumber = Random().nextInt(4);

  var visibility_report_button = true;

  void hideWidget() {
    setState(() {
      visibility_report_button = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _cameraController = widget.controller;

    return FutureBuilder(
      future: IAService.recognizeImageBinary(widget.image),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(
            'There was an error :(',
          );
        } else if (snapshot.hasData) {
          var predictions = snapshot.data as List<dynamic>;
          String? label = predictions[0]['label'].toString();
          final number = predictions[0]['confidence'];

          if (label == 'graph') {
            label = 'Graffiti';
          } else if (label == 'voiture') {
            label = 'Car';
          } else if (label == 'dechet') {
            label = 'Garbage';
          } else if (label == 'egout') {
            label = 'Sewer';
          }

          // Initial Selected Value
          String dropdownvalue = items[0];
          label == 'autre'
              ? dropdownvalue = items[randomNumber]
              : dropdownvalue = capitalize(label);

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
                Image.file(File(widget.image.path)),
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
                    child: PredictionBlock(
                      label: label,
                      percent: percent,
                    ),
                  ),
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
                      child: label_changed == true || label == 'autre'
                          ? Text(
                              "Is that (a)",
                              style: TextStyle(
                                color: kDarkTextColor,
                                fontSize: 30,
                              ),
                            )
                          : Text(
                              "Is that correct ?",
                              style: TextStyle(
                                color: kDarkTextColor,
                                fontSize: 30,
                              ),
                            ),
                    ),
                    label == "autre"
                        ? Container()
                        : Visibility(
                            visible: visibility_report_button,
                            child: ReportButton(
                              cameraController: _cameraController,
                              size: size,
                              image: widget.image,
                              label: dropdownvalue,
                              text: "It's perfect !",
                            ),
                          ),
                    Container(
                      width: size.width - 50,
                      height: 70,
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          alignment: Alignment.center,
                          value: dropdownvalue,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            hideWidget();
                            setState(() {
                              label_changed = true;
                              label = newValue;
                              dropdownvalue = newValue!;
                            });
                          },
                          onSaved: (String? newValue) {
                            hideWidget();
                          },
                        ),
                      ),
                    ),
                    label_changed == true || label == 'autre'
                        ? ReportButton(
                            cameraController: _cameraController,
                            size: size,
                            image: widget.image,
                            label: dropdownvalue,
                            text: "Yes it is !",
                          )
                        : Container(),
                    TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MapScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Change address',
                        style: TextStyle(
                          fontSize: 15,
                          color: kDarkTextColor,
                        ),
                      ),
                    )
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
