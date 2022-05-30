import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dymogo/constants.dart';
import 'package:dymogo/views/login/login_screen.dart';
import 'package:dymogo/viewmodel/signUp/sign_up_service.dart';
import 'package:dymogo/widgets/navigation_drawer_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    @override
    void dispose() {
      // Clean up the controller when the widget is removed from the
      // widget tree.
      _emailController.dispose();
      _passwordController.dispose();
      _passwordController2.dispose();
      super.dispose();
    }

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
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              color: kPrimaryColor,
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: screenHeight,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.05),
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
                                "Hello",
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
                                "Register a new account",
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
                              controller: _emailController,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kTextInputBg),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  prefixIcon: Icon(Icons.email),
                                  fillColor: kTextInputBg,
                                  filled: true,
                                  labelText: 'Email',
                                  hintText: 'Your Email'),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Email';
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
                            margin: const EdgeInsets.only(top: 25),
                            width: screenWidth * 0.8,
                            child: TextFormField(
                              controller: _passwordController2,
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
                                  helperStyle: TextStyle(
                                      color: kDarkTextColor, fontSize: 11),
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: 'Confirm Password',
                                  hintText: 'Type the password a second time'),
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
                                  if (_passwordController.text !=
                                      _passwordController2.text) {
                                    const AlertDialog(
                                      content: Text(
                                          'The passwords do not match. Please try again.'),
                                    );
                                  } else {
                                    await SignUp.signUp(
                                            _emailController.text,
                                            _emailController.text,
                                            _passwordController.text)
                                        .then((statusCode) => {
                                              if (statusCode == 200)
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          const LoginScreen(),
                                                    ),
                                                  )
                                                }
                                              else if (statusCode == 400)
                                                {
                                                  const AlertDialog(
                                                    content: Text(
                                                        'The email is already in use. Please try again.'),
                                                  )
                                                }
                                              else
                                                {
                                                  const AlertDialog(
                                                    content: Text(
                                                        'An error occurred. Please try again.'),
                                                  )
                                                }
                                            });
                                  }
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              )),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
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
                                        builder: (_) => const LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign in',
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
              ),
            ),
          ],
        ));
  }
}
