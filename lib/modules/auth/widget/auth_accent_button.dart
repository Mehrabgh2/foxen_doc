import 'package:flutter/material.dart';
import '../../../util/app_theme.dart';

class AuthAccentButton extends StatelessWidget {
  static const height = 46.0;
  final String text;
  final double width;
  final VoidCallback onPressed;

  const AuthAccentButton({
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
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        color: AppTheme.authAccentButtonColor,
        boxShadow: [
          BoxShadow(
            color: AppTheme.authAccentButtonTextColor.withOpacity(.4),
            blurRadius: 15,
            spreadRadius: -2,
          )
        ],
      ),
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
            color: AppTheme.authAccentButtonTextColor,
          ),
        ),
      ),
    );
  }
}
