import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final List<TextSpan>? styles;
  final EdgeInsetsGeometry padding;

  const ReusableText({
    super.key,
    required this.text,
    this.styles,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 14,
        ),
        children: styles,
      ),
    );
  }
}