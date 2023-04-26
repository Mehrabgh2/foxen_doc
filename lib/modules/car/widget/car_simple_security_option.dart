import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../widget/custom_svg_widget.dart';

class CarSimpleSecurityOption extends StatelessWidget {
  const CarSimpleSecurityOption({
    required this.isLoading,
    required this.isActive,
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final bool isLoading;
  final bool isActive;
  final String title;
  final String icon;
  final Function(bool value) onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 4,
      child: InkWell(
        onTap: isLoading ? null : () => onPressed(!isActive),
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .03,
                    child: CustomSvgWidget(
                      icon,
                      color: isActive
                          ? const Color(0xFF84C31E)
                          : const Color(0xFF757575),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .005,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .015,
                      vertical: size.height * .005,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF84C31E)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'YekanBakh-Regular',
                            color: isActive
                                ? Colors.white
                                : const Color(0xFF757575),
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * .0225,
                          ),
                        ),
                        if (isActive)
                          SizedBox(
                            width: size.width * .01,
                          ),
                        if (isActive)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 15,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: BlurryContainer(
                  blur: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: Color(0xFF32769E),
                        size: 35,
                      ),
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
