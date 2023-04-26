import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../widget/custom_svg_widget.dart';

class CarSecurityOption extends StatelessWidget {
  const CarSecurityOption({
    required this.title,
    required this.icon,
    required this.text,
    required this.isLoading,
    required this.isActive,
    required this.onPressed,
    super.key,
  });

  final String title;
  final String icon;
  final String text;
  final bool isLoading;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .08,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0EB),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: -8,
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * .0075,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'YekanBakh-Regular',
              color: const Color(0xFF5B5746),
              fontWeight: FontWeight.bold,
              fontSize: size.width * .0275,
            ),
          ),
          SizedBox(
            height: size.height * .0075,
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: isLoading ? null : onPressed,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            Text(
                              text,
                              style: TextStyle(
                                fontFamily: 'YekanBakh-Regular',
                                color: isActive
                                    ? const Color(0xFFF85763)
                                    : const Color(0xFF757575),
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * .0275,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(right: size.width * .035),
                              child: CustomSvgWidget(
                                icon,
                                color: isActive
                                    ? const Color(0xFFF85763)
                                    : const Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (isLoading)
                  Positioned.fill(
                    child: BlurryContainer(
                      blur: 10,
                      borderRadius: BorderRadius.circular(12),
                      child: const Center(
                        child: SpinKitFadingCircle(
                          color: Color(0xFF32769E),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
