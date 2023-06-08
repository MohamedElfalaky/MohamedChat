// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mohamed_chat/View/Screens/Welcome/welcome_controller.dart';
import 'package:mohamed_chat/View/Screens/Chat/chat_screen.dart';
import 'package:mohamed_chat/View/Screens/signup.dart';
import 'package:mohamed_chat/View/Widgets/my_button.dart';
import 'package:mohamed_chat/View/Widgets/my_textfield.dart';
import 'package:mohamed_chat/View/Widgets/square_tile.dart';
import 'package:mohamed_chat/helpers/myApplication.dart';

import '../MainScreen/super_main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  double _sigmaX = 2; // from 0-10
  double _sigmaY = 2; // from 0-10
  double _opacity = 0.2;
  double _width = 350;
  double _height = 300;
  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  'https://anmg-production.anmg.xyz/yaza-co-za_sfja9J2vLAtVaGdUPdH5y7gA',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    const Text("Hi !",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    ClipRect(
                      child: BackdropFilter(
                        filter:
                            ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 1)
                                  .withOpacity(_opacity),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.71,
                          child: Form(
                            key: _formKey,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // username textfield
                                  MyTextField(
                                    controller: usernameController,
                                    hintText: 'Email',
                                    obscureText: false,
                                  ),

                                  const SizedBox(height: 10),

                                  // sign in button
                                  MyButton(
                                    txt: "Continue",
                                    onTap: (() {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SuperMainScreen()),
                                        );
                                      } else {
                                        print('not valid');
                                      }
                                    }),
                                  ),

                                  const SizedBox(height: 10),

                                  // or continue with
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          thickness: 0.5,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          'Or',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          thickness: 0.5,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  // google + apple sign in buttons
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // facebook button
                                        SquareTile(
                                            imagePath:
                                                'assets/images/facebook.png',
                                            title: "Continue with Facebook"),
                                        SizedBox(height: 10),

                                        // google button
                                        InkWell(
                                          onTap: () =>
                                              WelcomeController.handleSignIn(
                                                  context),
                                          child: SquareTile(
                                            imagePath:
                                                'assets/images/google.png',
                                            title: "Continue with Google",
                                          ),
                                        ),

                                        SizedBox(height: 10),

                                        // apple button
                                        SquareTile(
                                            imagePath:
                                                'assets/images/apple.png',
                                            title: "Continue with Apple"),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // not a member? register now
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Text(
                                              'Don\'t have an account?',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                              textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(width: 4),
                                            InkWell(
                                              onTap: () =>
                                                  myApplication.navigateTo(
                                                      Signup(), context),
                                              child: const Text(
                                                'Sign Up',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 71, 233, 133),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        const Text('Forgot Password?',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 71, 233, 133),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                            textAlign: TextAlign.start),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
