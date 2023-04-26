import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../widget/custom_svg_widget.dart';

class AddCardCarView extends StatelessWidget {
  const AddCardCarView({
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: DottedBorder(
        radius: const Radius.circular(18),
        borderType: BorderType.RRect,
        color: const Color(0xFF189A93),
        strokeWidth: 4,
        dashPattern: const [6, 3.5],
        padding: EdgeInsets.zero,
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFDCDACB).withAlpha(100),
                const Color(0xFFDCDACB).withAlpha(50)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(18),
            color: Colors.transparent,
            child: InkWell(
              overlayColor: MaterialStateColor.resolveWith(
                (states) => const Color(0xFF189A93).withAlpha(20),
              ),
              borderRadius: BorderRadius.circular(18),
              onTap: onPressed,
              child: BlurryContainer(
                padding: EdgeInsets.symmetric(horizontal: size.width * .03),
                color: Colors.transparent,
                blur: 12,
                borderRadius: BorderRadius.circular(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomSvgWidget('assets/car/add_car.svg'),
                    Text(
                      'اضافه کردن ماشین جدید',
                      style: TextStyle(
                        fontFamily: 'YekanBakh-Regular',
                        color: const Color(0xFF189A93),
                        fontSize: size.width * .04,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
