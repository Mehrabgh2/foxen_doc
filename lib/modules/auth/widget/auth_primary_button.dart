import 'package:flutter/material.dart';

import '../../../util/app_theme.dart';

class AuthPrimaryButton extends StatelessWidget {
  static const height = 46.0;
  final String text;
  final VoidCallback onPressed;

  const AuthPrimaryButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .325,
      height: height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          color: AppTheme.successColor),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'YekanBakh-Bold',
            fontSize: size.width * .035,
            fontWeight: FontWeight.bold,
            color: AppTheme.authPrimaryButtonTextColor,
          ),
        ),
      ),
    );
  }
}
