import 'package:dymogo/views/signup/signup_screen.dart';
import 'package:dymogo/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dymogo/constants.dart';
import 'package:dymogo/views/camera/camera_screen.dart';
import 'package:dymogo/views/login/login_screen.dart';
import 'package:dymogo/viewmodel/signIn/sign_in_service.dart';

class HomeScreen extends StatelessWidget {
  final authenticated;

  const HomeScreen({Key? key, required this.authenticated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Scaffold(
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              color: kPrimaryColor,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(
                      "assets/images/written_logo.svg",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: screenWidth * 0.35,
                    margin: EdgeInsets.only(top: screenHeight * 0.05),
                    child: SvgPicture.asset(
                      "assets/images/w_logo.svg",
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 30, left: 25),
                          child: const Text(
                            "WELCOME",
                            style: TextStyle(
                              color: kDarkTextColor,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 25),
                          child: const Text(
                            "Do you want to report something ?",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      authenticated
                          ? Container(
                              height: 25,
                            )
                          : Container(),
                      Container(
                          width: screenWidth * 0.8,
                          height: 60,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [kPrimaryColor, kSecondaryColor]),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            color: kPrimaryColor,
                          ),
                          child: TextButton(
                            onPressed: () async {
                              authenticated
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CameraScreen()))
                                  : showAlertDialog(context);
                            },
                            child: const Text(
                              "Report",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )),
                      authenticated
                          ? Container()
                          : Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                "or",
                                style: TextStyle(fontSize: 14, color: kGrey),
                              ),
                            ),
                      authenticated
                          ? Container()
                          : Container(
                              width: screenWidth * 0.8,
                              height: 60,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                color: Colors.transparent,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontSize: 14, color: kPrimaryColor),
                                ),
                              )),
                      authenticated
                          ? Container(
                              height: 75,
                            )
                          : Container(
                              width: screenWidth * 0.8,
                              height: 60,
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 30),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [kPrimaryColor, kSecondaryColor]),
                                border: Border.all(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                color: Colors.transparent,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 14, color: kPrimaryColor),
                                ),
                              ))
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Annulé"),
    onPressed: () => Navigator.pop(context),
  );
  Widget connectButton = TextButton(
    child: Text("Se connecter"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continuer"),
    onPressed: () async {
      await SignIn.authenticateWithMobileId().then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => CameraScreen())));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Déconnecté"),
    content: Text(
        "Attention vous n'êtes pas authentifié. Nous créerons tout de même un compte en relation avec cet appareil afin de sauvegardé vos alertes."),
    actions: [
      cancelButton,
      connectButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
