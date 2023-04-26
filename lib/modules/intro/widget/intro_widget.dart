import 'package:flutter/material.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    required this.image,
    required this.child,
    super.key,
  });

  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: size.width,
          height: size.height * .4,
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: size.height * .1,
        ),
        Text(
          'در هر مکان و در هر زمان',
          style: TextStyle(
            fontSize: size.width * .0375,
            fontFamily: 'YekanBakh-Bold',
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2294B1),
          ),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        child,
        SizedBox(
          height: size.height * .06,
        ),
      ],
    );
  }
}
