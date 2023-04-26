import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../util/app_theme.dart';

class HyperLinkText extends StatelessWidget {
  final double textSize;
  final String? text;
  final String? secondText;
  final String hyperText;
  final Color hyperColor;
  final VoidCallback? onPressed;

  const HyperLinkText({
    required this.textSize,
    this.text,
    this.secondText,
    required this.hyperText,
    required this.hyperColor,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          if (text != null)
            TextSpan(
              text: text,
              style: TextStyle(
                color: AppTheme.textFieldTextColor,
                fontSize: textSize,
                fontFamily: "YekanBakh-Regular",
              ),
            ),
          TextSpan(
            text: hyperText,
            style: TextStyle(
              color:
                  onPressed != null ? hyperColor : AppTheme.textFieldTextColor,
              fontSize: textSize,
              fontFamily: "YekanBakh-Regular",
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onPressed,
          ),
          if (secondText != null)
            TextSpan(
              text: secondText,
              style: TextStyle(
                color: AppTheme.textFieldTextColor,
                fontSize: textSize,
                fontFamily: "YekanBakh-Regular",
              ),
            ),
        ],
      ),
    );
  }
}
