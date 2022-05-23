import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dymogo/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../size_config.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    const urlimg = 'assets/images/register/background.png';

    return Scaffold(
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
            onTap: () => {Navigator.pop(context)},
            child: const Icon(
              Icons.arrow_back,
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
                padding: EdgeInsets.only(top: 120),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Log In",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0),
                              height: 2,
                              width: 55,
                              color: kPrimaryColor,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              height: 2,
                              width: 55,
                              color: kPrimaryColor,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                      width: 100,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto', color: kPrimaryColor),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                        SizedBox(height: 30.0),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Password ',
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto', color: kPrimaryColor),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          obscureText: true,
                        ),
                        SizedBox(height: 20.0),
                      ]),
                    ),
                    Container(
                        width: 250,
                        height: 70,
                        margin: const EdgeInsets.only(top: 40),
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
                            "Sign In",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "No account ? ",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black87)),
                            TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 10)),
                          ]),
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
