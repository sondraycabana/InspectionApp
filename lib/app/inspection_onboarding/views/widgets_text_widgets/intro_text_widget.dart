import 'package:flutter/material.dart';

class IntroTextWidget extends StatelessWidget {
  const IntroTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: const TextSpan(
        text: "Park your Vehicle in a ",
        style: TextStyle(
          height: 1.5,
          fontSize: 14,
          color: Color(0xff344054),
        ),
        children: [
          TextSpan(
            text: 'well-lit, shaded, ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'and ',
          ),
          TextSpan(
            text: 'spacious area, ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'ensuring there are ',
          ),
          TextSpan(
            text: 'no obstructions.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}