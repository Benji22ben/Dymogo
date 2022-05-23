import 'package:dymogo/views/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dymogo/constants.dart';
import 'package:dymogo/viewmodel/loginViewModel/loginViewModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Create storage
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    @override
    void dispose() {
      // Clean up the controller when the widget is removed from the
      // widget tree.
      _usernameController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    height: screenHeight * 0.20,
                    width: screenWidth * 0.25,
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
                          controller: _usernameController,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kTextInputBg),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
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
                          controller: _passwordController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kTextInputBg),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              fillColor: kTextInputBg,
                              filled: true,
                              helperText: 'Forgot your password ?',
                              helperStyle: TextStyle(
                                  color: kDarkTextColor, fontSize: 11),
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
                            onPressed: () async {
                              var token = await LoginViewModel.login(
                                  _usernameController.text,
                                  _passwordController.text);
                              await storage.write(key: "token", value: token);
                            },
                            child: const Text(
                              "Sign In",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )),
                      Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'No account ?',
                              style: TextStyle(
                                  color: kDarkTextColor, fontSize: 11),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 11),
                              ),
                            )
                          ],
                        ),
                      )
                    ]))
              ],
            ),
          ],
        ));
  }
}
