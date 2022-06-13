import 'package:flutter/material.dart';
// import 'package:simple_shadow/simple_shadow.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dymogo/constants.dart';
import 'package:dymogo/widgets/navigation_drawer_widget.dart';
import 'package:dymogo/views/signup/signup_screen.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const urlimg = 'assets/images/login_screen/bg.png';

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(title: Text("Test")),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(urlimg), fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 15),
              child: GestureDetector(
                onTap: () => {Scaffold.of(context).openEndDrawer()},
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ColumnSuper(
                innerDistance: -105,
                invert: true,
                children: [
                  Container(
                    width: screenWidth * 0.80,
                    height: screenHeight * 0.65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(214, 212, 212, 0.25),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ]),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 95,
                          width: 100,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: const Text(
                            "WELCOME",
                            style: TextStyle(
                              color: kDarkTextColor,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Do you want to report something ?",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                            width: 250,
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
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) => const CameraScreen(),
                                //   ),
                                // );
                              },
                              child: const Text(
                                "Report",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "or",
                            style: TextStyle(fontSize: 14, color: kGrey),
                          ),
                        ),
                        Container(
                            width: 250,
                            height: 50,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: kPrimaryColor, width: 2.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Colors.transparent,
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Log In",
                                style: TextStyle(
                                    fontSize: 14, color: kPrimaryColor),
                              ),
                            )),
                        Container(
                            width: 250,
                            height: 50,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [kPrimaryColor, kSecondaryColor]),
                              border:
                                  Border.all(color: kPrimaryColor, width: 2.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
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
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 14, color: kPrimaryColor),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
