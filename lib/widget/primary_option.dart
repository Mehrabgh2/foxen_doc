import 'package:flutter/material.dart';
import 'package:foxenapp/widget/custom_svg_widget.dart';

class PrimaryOption extends StatelessWidget {
  const PrimaryOption({
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });
  final String title;
  final String icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * .01,
        horizontal: size.width * .04,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        shadowColor: Colors.grey.withAlpha(30),
        elevation: 8,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1.5,
                color: const Color(0xFFEEEEEE),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: size.height * .0175,
              horizontal: size.width * .025,
            ),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  padding: const EdgeInsets.all(8),
                  child: const FittedBox(
                    child: CustomSvgWidget(
                      'assets/authentication/chevron_back.svg',
                      color: Color(0xFFC2C2C2),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'YekanBakh-Regular',
                          color: const Color(0xFF32769E),
                          fontSize: size.width * .035,
                        ),
                      ),
                      SizedBox(
                        width: size.width * .065,
                      ),
                      SizedBox(
                        width: size.height * .035,
                        height: size.height * .035,
                        child: FittedBox(
                          child: CustomSvgWidget(icon),
                        ),
                      ),
                      SizedBox(
                        width: size.width * .02,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
