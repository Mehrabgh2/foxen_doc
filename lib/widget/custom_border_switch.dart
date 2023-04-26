import 'package:flutter/material.dart';

class CustomBorderSwitch extends StatelessWidget {
  const CustomBorderSwitch({
    required this.onPressed,
    required this.value,
    super.key,
  });

  final VoidCallback onPressed;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: size.height * .04,
        width: size.width * .15,
        child: Stack(
          children: [
            Positioned(
              top: size.height * .0135,
              bottom: size.height * .0135,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color:
                      value ? const Color(0xFF84C31E) : const Color(0xFFC2C2C2),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              top: size.height * .0025,
              bottom: size.height * .0025,
              left: value ? (size.width * .15) - (size.height * .035) : 0,
              child: Container(
                width: size.height * .035,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  border: Border.all(
                    width: 1.5,
                    color: const Color(0xFF32769E),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
