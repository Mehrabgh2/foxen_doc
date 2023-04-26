import 'package:flutter/material.dart';

import '../../../util/app_theme.dart';

class AuthCancelButton extends StatelessWidget {
  static const height = 46.0;
  final String text;
  final double width;
  final VoidCallback onPressed;

  const AuthCancelButton({
    required this.text,
    this.width = .325,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * width,
      height: height,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        color: AppTheme.authCancelButtonColor,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'YekanBakh-Bold',
            fontSize: size.width * .035,
            fontWeight: FontWeight.bold,
            color: AppTheme.authCancelButtonTextColor,
          ),
        ),
      ),
    );
  }
}
