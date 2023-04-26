import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../widget/custom_svg_widget.dart';

class CarInfoSecurityOption extends StatelessWidget {
  const CarInfoSecurityOption({
    required this.isLargeSize,
    required this.title,
    required this.child,
    required this.isLoading,
    required this.isActive,
    required this.onPressed,
    this.onInfoPressed,
    this.onEdit,
    super.key,
  });

  final bool isLargeSize;
  final String title;
  final Widget child;
  final bool isLoading;
  final bool isActive;
  final Function()? onPressed;
  final VoidCallback? onInfoPressed;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: isLargeSize ? size.height * .16 : size.height * .085,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .015),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                onInfoPressed != null
                    ? InkWell(
                        onTap: onInfoPressed,
                        child: const CustomSvgWidget('assets/car/info.svg'),
                      )
                    : const SizedBox(),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF5B5746),
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * .0275,
                  ),
                ),
                onEdit != null
                    ? InkWell(
                        onTap: onEdit!,
                        child: Icon(
                          Icons.edit,
                          color: const Color(0xFF565656),
                          size: size.height * .02,
                        ),
                      )
                    : const Opacity(
                        opacity: 0,
                        child: CustomSvgWidget('assets/car/info.svg'),
                      ),
              ],
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
                        child: child,
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
                          size: 40,
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
