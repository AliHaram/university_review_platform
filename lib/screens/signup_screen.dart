import 'package:flutter/material.dart';
import '../widgets/signup_screen_top_image.dart';
import '../widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: SignupScreenTopImage(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_bottom.png',
              width: 150,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 100), // Adjust spacing as needed
                  SignupForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
