import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreenTopImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/signup.svg', // Ensure this image exists in your assets folder
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
