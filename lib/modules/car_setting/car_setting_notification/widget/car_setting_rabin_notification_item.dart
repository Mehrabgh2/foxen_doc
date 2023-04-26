import 'package:flutter/cupertino.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/dialog_box.dart';

class CarSettingRabinNotificationItem extends StatelessWidget {
  const CarSettingRabinNotificationItem({
    required this.title,
    required this.info,
    required this.isCallOn,
    required this.isSmsOn,
    required this.updateCallOn,
    required this.updateSmsOn,
    this.haveCall = true,
    this.haveSms = true,
    this.downChild,
    super.key,
  });

  final String title;
  final String info;
  final bool isCallOn;
  final bool isSmsOn;
  final Function(bool) updateCallOn;
  final Function(bool) updateSmsOn;
  final Widget? downChild;
  final bool haveCall;
  final bool haveSms;

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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () =>
                    DialogBox.showInfoDialog(context: context, info: info),
                child: const CustomSvgWidget('assets/car/info.svg'),
              ),
              SizedBox(
                width: size.width * .02,
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'YekanBakh-Bold',
                  color: const Color(0xFF32769E),
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * .035,
                ),
              )
            ],
          ),
          if (haveCall)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoSwitch(
                  value: isCallOn,
                  onChanged: (value) {
                    updateCallOn(value);
                  },
                  activeColor: const Color(0xFF189A93),
                ),
                Text(
                  'تماس',
                  style: TextStyle(
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF828282),
                    fontSize: size.width * .03,
                  ),
                ),
              ],
            ),
          if (haveSms)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoSwitch(
                  value: isSmsOn,
                  onChanged: (value) {
                    updateSmsOn(value);
                  },
                  activeColor: const Color(0xFF189A93),
                ),
                Text(
                  'پیامک',
                  style: TextStyle(
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF828282),
                    fontSize: size.width * .03,
                  ),
                ),
              ],
            ),
          if (downChild != null)
            Column(
              children: [
                SizedBox(
                  height: size.height * .01,
                ),
                downChild!,
              ],
            ),
        ],
      ),
    );
  }
}
