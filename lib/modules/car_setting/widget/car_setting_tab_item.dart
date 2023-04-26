import 'package:flutter/material.dart';

import '../../../widget/custom_svg_widget.dart';

class CarSettingTabItem extends StatelessWidget {
  const CarSettingTabItem({
    required this.selected,
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final bool selected;
  final String title;
  final String icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .4,
      height: size.height * .0475,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          width: 1.25,
          color: selected ? const Color(0xFF189A93) : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            spreadRadius: -2,
            blurRadius: 15,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(13),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .03,
              vertical: size.height * .005,
            ),
            child: Opacity(
              opacity: selected ? 1 : .5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: size.width * .0285,
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF189A93),
                    ),
                  ),
                  FittedBox(child: CustomSvgWidget(icon)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
