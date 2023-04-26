import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../../model/response/odometer_history_response.dart';
import '../../../../util/app_util.dart';
import '../../../../widget/custom_svg_widget.dart';

class CarSettingOdometerHistoryItem extends StatelessWidget {
  const CarSettingOdometerHistoryItem({
    required this.history,
    super.key,
  });

  final OdometerHistory history;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        top: size.height * .0075,
        bottom: size.height * .0075,
      ),
      padding: EdgeInsets.symmetric(
        vertical: size.height * .01,
        horizontal: size.width * .04,
      ),
      height: size.height * .1,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(80),
            spreadRadius: -2,
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    'کیلومتر',
                    style: TextStyle(
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF565656),
                      fontSize: size.width * .0325,
                    ),
                  ),
                  SizedBox(
                    width: size.width * .01,
                  ),
                  Text(
                    AppUtil.replacePersianNumber(
                      (history.oldOdometer ?? 0).toString(),
                    ),
                    style: TextStyle(
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF565656),
                      fontSize: size.width * .0325,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: size.width * .075,
              ),
              Text(
                'از',
                style: TextStyle(
                  fontFamily: 'YekanBakh-Regular',
                  color: const Color(0xFF565656),
                  fontSize: size.width * .0325,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              getDate(history.odometerTimestamp, size),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  const CustomSvgWidget(
                      'assets/car/car_setting_odometer_history_check.svg'),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  Text(
                    'کیلومتر',
                    style: TextStyle(
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF32769E),
                      fontSize: size.width * .0325,
                    ),
                  ),
                  SizedBox(
                    width: size.width * .01,
                  ),
                  Text(
                    AppUtil.replacePersianNumber(
                      (history.odometer ?? 0).toString(),
                    ),
                    style: TextStyle(
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF32769E),
                      fontSize: size.width * .0325,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: size.width * .075,
              ),
              Text(
                'به',
                style: TextStyle(
                  fontFamily: 'YekanBakh-Regular',
                  color: const Color(0xFF565656),
                  fontSize: size.width * .0325,
                ),
              ),
            ],
          ),
        ],
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * .02,
              width: size.height * .02,
              child: const FittedBox(
                child: CustomSvgWidget(
                  'assets/car/calendar.svg',
                  color: Color(0xFF89CCC8),
                ),
              ),
            ),
            SizedBox(
              width: size.width * .015,
            ),
            Text(
              AppUtil.replacePersianNumber('$year-$month-$dayString'),
              style: TextStyle(
                fontSize: size.width * .03,
                fontFamily: 'YekanBakh-Regular',
                color: const Color(0xFF8D8D8D),
              ),
            ),
            SizedBox(width: size.width * .025),
            Text(
              AppUtil.replacePersianNumber('$hourString:$minuteString'),
              style: TextStyle(
                fontSize: size.width * .03,
                fontFamily: 'YekanBakh-Regular',
                color: const Color(0xFF8D8D8D),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
