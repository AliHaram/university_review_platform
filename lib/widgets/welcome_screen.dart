import 'package:flutter/material.dart';
import 'login_signup_btn.dart';
import 'welcome_image.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: 150,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: 150,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WelcomeImage(),
                SizedBox(height: 20),
                LoginSignupBtn(
                  loginCallback: () => Navigator.pushNamed(context, '/login'),
                  signupCallback: () => Navigator.pushNamed(context, '/signup'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
