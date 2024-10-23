import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'responsive.dart';
import 'social_icon.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Responsive(
          mobile: MobileSignUpScreen(),
          tablet: TabletSignUpScreen(),
          desktop: DesktopSignUpScreen(),
        ),
      ),
    );
  }
}

class MobileSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "SIGN UP",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          SvgPicture.asset(
            "assets/icons/signup.svg",
            height: 150,
          ),
          SizedBox(height: 20),
          SignUpForm(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SocialIcon(
                iconSrc: "assets/icons/facebook.svg",
                press: () {},
              ),
              SocialIcon(
                iconSrc: "assets/icons/twitter.svg",
                press: () {},
              ),
              SocialIcon(
                iconSrc: "assets/icons/google-plus.svg",
                press: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TabletSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SvgPicture.asset("assets/icons/signup.svg"),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "SIGN UP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                SignUpForm(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocialIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocialIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocialIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DesktopSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SvgPicture.asset("assets/icons/signup.svg"),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "SIGN UP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                SignUpForm(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocialIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocialIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocialIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Navigate to home page or show success message
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _signUp,
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
