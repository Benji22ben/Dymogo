import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dymogo/constants.dart';
import 'package:dymogo/size_config.dart';
import 'package:dymogo/screens/camera/camera_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    const urlimg = 'assets/images/map.png';

    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(urlimg), fit: BoxFit.cover)),
        ),
        Align(
          alignment: Alignment.center,
          child: ColumnSuper(
            innerDistance: -105,
            invert: true,
            children: [
              SimpleShadow(
                opacity: 0.25,
                offset: const Offset(0, 1),
                color: kShadow,
                sigma: 10,
                child: SvgPicture.asset(
                  "assets/images/logo.svg",
                ),
              ),
              Container(
                width: SizeConfig.screenWidth! * 0.80,
                height: SizeConfig.screenHeight! * 0.65,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CameraScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Report",
                            style: TextStyle(fontSize: 18, color: Colors.white),
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
                          border: Border.all(color: kPrimaryColor, width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Colors.transparent,
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Log In",
                            style:
                                TextStyle(fontSize: 14, color: kPrimaryColor),
                          ),
                        )),
                    Container(
                        width: 250,
                        height: 50,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [kPrimaryColor, kSecondaryColor]),
                          border: Border.all(color: kPrimaryColor, width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Colors.transparent,
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Sign In",
                            style:
                                TextStyle(fontSize: 14, color: kPrimaryColor),
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
