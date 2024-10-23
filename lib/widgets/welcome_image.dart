import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "WELCOME TO RATE MY PROF!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset("assets/icons/chat.svg"), // Reference to the SVG file
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
