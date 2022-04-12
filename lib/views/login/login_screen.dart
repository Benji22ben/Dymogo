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
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: 125,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [kPrimaryColor, kSecondaryColor]),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: kPrimaryColor,
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Log In",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                )),
                            Container(
                                width: 120,
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 16, color: kSecondaryColor),
                                  ),
                                )),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        )),
                    const FormWidget(),
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
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                  }
                },
                child: const Text(
                  "Log In",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )),
          InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => const SignInScreen(),
                //   ),
                // );
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
                          "Sign in",
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
