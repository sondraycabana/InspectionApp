import 'package:flutter/material.dart';

class RightTextWidget extends StatelessWidget {
  const RightTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: const TextSpan(
        text: "Take picture of your ",
        style: TextStyle(
          height: 1.5,
          fontSize: 14,
          color: Color(0xff344054),
        ),
        children: [
          TextSpan(
            text: 'Vehicle\'s ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Right ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff3BAA90),
            ),
          ),
          TextSpan(
            text: ', ensuring it fills about ',
          ),
          TextSpan(
            text: '80% ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff12B76A),
            ),
          ),
          TextSpan(
            text: 'of your camera screen',
          ),
        ],
      ),
    );
  }
}