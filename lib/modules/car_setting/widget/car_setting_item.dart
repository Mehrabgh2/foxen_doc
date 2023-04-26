import 'package:flutter/material.dart';
import '../../../widget/custom_svg_widget.dart';

class CarSettingItem extends StatelessWidget {
  const CarSettingItem({
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: const Color(0xFFEEEEEE)),
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
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .03,
              vertical: size.height * .02,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.chevron_left_rounded,
                  color: Color(0xFFC2C2C2),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width * .035,
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF32769E),
                  ),
                ),
                SizedBox(
                  width: size.width * .035,
                ),
                CustomSvgWidget(icon),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
