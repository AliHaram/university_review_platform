import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;

  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(29),
            ),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email, color: kPrimaryColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(29),
            ),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.lock, color: kPrimaryColor),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              obscureText: _obscureText,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _signIn,
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(29),
              ),
            ),
            child: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? "),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  'Sign up!',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
