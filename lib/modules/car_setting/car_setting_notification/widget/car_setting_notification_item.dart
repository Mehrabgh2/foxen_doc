import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/dialog_box.dart';

class CarSettingNotificationItem extends StatelessWidget {
  const CarSettingNotificationItem({
    required this.title,
    required this.isOn,
    required this.updateOn,
    this.info,
    this.downChild,
    super.key,
  });

  final String title;
  final String? info;
  final bool isOn;
  final Function(bool) updateOn;
  final Widget? downChild;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * .015,
        horizontal: size.width * .04,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CupertinoSwitch(
                value: isOn,
                onChanged: (value) {
                  updateOn(value);
                },
                activeColor: const Color(0xFF189A93),
              ),
              const Expanded(child: SizedBox()),
              info != null
                  ? InkWell(
                      onTap: () => DialogBox.showInfoDialog(
                          context: context, info: info!),
                      child: const CustomSvgWidget('assets/car/info.svg'),
                    )
                  : const SizedBox(),
              SizedBox(
                width: size.width * .02,
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'YekanBakh-Bold',
                  color: const Color(0xFF32769E),
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * .0325,
                ),
              ),
            ],
          ),
          if (downChild != null)
            Column(
              children: [
                SizedBox(
                  height: size.height * .015,
                ),
                downChild!,
              ],
            ),
        ],
      ),
    );
  }
}
