import 'package:flutter/material.dart';

class MaxLengthText extends StatelessWidget {
  const MaxLengthText(
    this.text, {
    required this.style,
    required this.maxLength,
    this.textAlign = TextAlign.right,
    super.key,
  });

  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.length < maxLength ? text : text.substring(0, maxLength),
      style: style,
    );
  }
}
