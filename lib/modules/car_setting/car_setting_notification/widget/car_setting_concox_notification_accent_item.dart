import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foxenapp/widget/custom_text_field.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/dialog_box.dart';

class CarSettingConcoxNotificationAccentItem extends StatelessWidget {
  const CarSettingConcoxNotificationAccentItem({
    required this.title,
    required this.isOn,
    required this.updateOn,
    required this.maxSpeedController,
    required this.timeSpeedController,
    this.info,
    super.key,
  });

  final String title;
  final String? info;
  final bool isOn;
  final Function(bool) updateOn;
  final TextEditingController maxSpeedController;
  final TextEditingController timeSpeedController;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          SizedBox(
            height: size.height * .0125,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: maxSpeedController,
                  type: TextInputType.number,
                  textAlign: TextAlign.right,
                  leftWidget: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .02,
                    ),
                    child: Text(
                      'کیلومتر بر ساعت',
                      style: TextStyle(
                        fontFamily: 'YekanBakh-Regular',
                        color: const Color(0xFF8D8D8D),
                        fontSize: size.width * .025,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'سرعت هشدار',
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF828282),
                    fontSize: size.width * .03,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * .005,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: timeSpeedController,
                  type: TextInputType.number,
                  textAlign: TextAlign.right,
                  leftWidget: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .02,
                    ),
                    child: Text(
                      'ثانیه',
                      style: TextStyle(
                        fontFamily: 'YekanBakh-Regular',
                        color: const Color(0xFF8D8D8D),
                        fontSize: size.width * .025,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'مدت زمان کنترل سرعت',
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF828282),
                    fontSize: size.width * .03,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
