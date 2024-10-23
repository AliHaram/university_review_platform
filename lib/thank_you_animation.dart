import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ThankYouAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/thank_you.json', // Add your Lottie animation file here
        width: 150,
        height: 150,
        fit: BoxFit.fill,
      ),
    );
  }
}
