import 'package:flutter/material.dart';
import '../constants.dart';

class LoginSignupBtn extends StatelessWidget {
  final VoidCallback loginCallback;
  final VoidCallback signupCallback;

  LoginSignupBtn({required this.loginCallback, required this.signupCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: loginCallback,
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor, // Use backgroundColor instead of primary
            foregroundColor: Colors.white, // Use foregroundColor instead of onPrimary
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(29.0),
            ),
          ),
          child: Text('Login'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: signupCallback,
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryLightColor, // Use backgroundColor instead of primary
            foregroundColor: Colors.black, // Use foregroundColor instead of onPrimary
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(29.0),
            ),
          ),
          child: Text('Sign Up'),
        ),
      ],
    );
  }
}
