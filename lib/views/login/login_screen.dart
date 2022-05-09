import 'package:dymogo/views/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dymogo/constants.dart';
import 'package:dymogo/size_config.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: kPrimaryColor,
        ),
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 25, left: 10),
                child: SvgPicture.asset(
                  "assets/images/written_logo.svg",
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: screenWidth * 0.25,
                child: SvgPicture.asset(
                  "assets/images/w_logo.svg",
                ),
              ),
            ),
            const Spacer(),
            Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.white,
                ),
                child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(top: 30, left: 25),
                      child: const Text(
                        "Welcome",
                        style: TextStyle(
                          color: kDarkTextColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 25),
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          color: kDarkTextColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 25),
                      child: const Text(
                        "Log In to your account",
                        style: TextStyle(
                          color: kDarkTextColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: screenWidth * 0.8,
                    child: TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kTextInputBg),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          fillColor: kTextInputBg,
                          filled: true,
                          labelText: 'Username',
                          hintText: 'Your username'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: screenWidth * 0.8,
                    child: TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kTextInputBg),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          fillColor: kTextInputBg,
                          filled: true,
                          helperText: 'Forgot your password ?',
                          helperStyle:
                              TextStyle(color: kDarkTextColor, fontSize: 11),
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          hintText: 'Your password'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                      width: screenWidth * 0.8,
                      height: 60,
                      margin: const EdgeInsets.only(top: 50),
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
                        onPressed: () {
                          // Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          // builder: (_) => const CameraScreen(),
                          // ),
                          // );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "or",
                      style: TextStyle(fontSize: 14, color: kDarkTextColor),
                    ),
                  ),
                ]))
          ],
        ),
      ],
    ));
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              floatingLabelStyle:
                                  TextStyle(color: kPrimaryColor),
                              hintText: 'Your username',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                      ),
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            helperText: 'Forgot your password ?',
                            labelText: 'Password',
                            floatingLabelStyle: TextStyle(color: kPrimaryColor),
                            hintText: 'Your password'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )
              ],
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
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: kPrimaryColor,
              ),
              child: TextButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   // Process data.
                  // }
                },
                child: const Text(
                  "Log In",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignUpScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: const [
                        Text(
                          "No account ? ",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        )
                      ],
                    ),
                    Column(
                      children: const [
                        Text(
                          "Sign up",
                          style:
                              TextStyle(fontSize: 14, color: kSecondaryColor),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
