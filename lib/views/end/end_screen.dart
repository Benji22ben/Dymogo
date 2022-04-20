import 'package:dymogo/views/home/home_screen.dart';
import 'package:dymogo/views/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dymogo/constants.dart';
import 'package:dymogo/size_config.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    const urlimg = 'assets/images/login_screen/bg.png';

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
            invert: true,
            children: [
              Container(
                width: SizeConfig.screenWidth! * 0.80,
                height: SizeConfig.screenHeight! * 0.75,
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
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text(
                        "Thank you !",
                        style: TextStyle(
                          color: kDarkTextColor,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: const Text(
                        "Your report will be considered as soon as possible.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
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
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Back Home",
                            style: TextStyle(fontSize: 18, color: Colors.white),
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
