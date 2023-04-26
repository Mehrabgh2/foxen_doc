import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../model/foxen_device.dart';
import '../../../util/app_util.dart';
import '../../../widget/custom_svg_widget.dart';
import '../screen/car_security_history_details_screen.dart';

class CarSecurityHistoryItem extends StatelessWidget {
  const CarSecurityHistoryItem({required this.security, super.key});
  final Security security;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .1,
      margin: EdgeInsets.symmetric(
        vertical: size.height * .01,
        horizontal: size.width * .04,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 2, color: const Color(0xFFEEEEEE)),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: -7,
            blurRadius: 15,
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Get.to(
              () => CarSecurityHistoryDetailsScreen(
                security: security,
                date: getDate(security.timestamp, size),
              ),
              transition: Transition.rightToLeft,
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * .01,
              horizontal: size.width * .04,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    security.secTypeString ?? 'nothing',
                    style: TextStyle(
                      fontSize: size.width * .03,
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF32769E),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 14,
                      width: 10,
                      child: CustomSvgWidget(
                        'assets/authentication/chevron_back.svg',
                        color: Color(0xFFC2C2C2),
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    getDate(security.timestamp, size),
                    const Expanded(child: SizedBox()),
                    Text(
                      (security.typeSec ?? 0) == 0 ? 'ریموت فیزیکی' : 'فاکسن',
                      style: TextStyle(
                        fontSize: size.width * .03,
                        fontFamily: 'YekanBakh-Regular',
                        color: const Color(0xFF4F4F4F),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDate(num? timestamp, Size size) {
    if (timestamp == null) {
      return const SizedBox();
    }
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).floor());
    Jalali shamsiDate = Jalali.fromDateTime(date);
    int year = shamsiDate.year;
    int month = shamsiDate.month;
    int day = shamsiDate.day;
    int hour = shamsiDate.hour;
    int minute = shamsiDate.minute;
    String dayString = day.toString().padLeft(2, '0');
    String hourString = hour.toString().padLeft(2, '0');
    String minuteString = minute.toString().padLeft(2, '0');
    return Row(
      children: [
        Row(
          children: [
            Text(
              AppUtil.replacePersianNumber('$hourString:$minuteString'),
              style: TextStyle(
                fontSize: size.width * .03,
                fontFamily: 'YekanBakh-Regular',
                color: const Color(0xFF8D8D8D),
              ),
            ),
            SizedBox(width: size.width * .025),
            Text(
              AppUtil.replacePersianNumber('$year-$month-$dayString'),
              style: TextStyle(
                fontSize: size.width * .03,
                fontFamily: 'YekanBakh-Regular',
                color: const Color(0xFF8D8D8D),
              ),
            ),
          ],
        ),
        SizedBox(
          width: size.width * .015,
        ),
        const CustomSvgWidget('assets/car/calendar.svg')
      ],
    );
  }
}
