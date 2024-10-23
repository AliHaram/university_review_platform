import 'package:flutter/material.dart';
import '../widgets/login_screen_top_image.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: LoginScreenTopImage(),
          ),
          Positioned(
            bottom: 1,
            right: 1,
            child: Image.asset(
              'assets/images/login_bottom.png',
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
                  LoginForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
