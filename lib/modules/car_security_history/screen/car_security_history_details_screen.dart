import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/foxen_device.dart';
import '../../../util/app_util.dart';
import '../../../widget/home_appbar.dart';
import '../../car/widget/car_speed_gauge.dart';

class CarSecurityHistoryDetailsScreen extends StatelessWidget {
  const CarSecurityHistoryDetailsScreen({
    required this.security,
    required this.date,
    super.key,
  });

  final Security security;
  final Widget date;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          HomeAppBar(
            title: 'سوابق دزدگیر',
            onBack: Get.back,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * .03,
                horizontal: size.width * .05,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      date,
                      const Expanded(child: SizedBox()),
                      Text(
                        security.secTypeString ?? '',
                        style: TextStyle(
                          color: const Color(0xFF32769E),
                          fontSize: size.width * .05,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'YekanBakh-Bold',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .035,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .035,
                      vertical: size.height * .02,
                    ),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: -7,
                          blurRadius: 15,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (security.input!.autoLock ?? false)
                                    Text(
                                      'قفل خودکار',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                      ),
                                    ),
                                  if (security.input!.childLock ?? false)
                                    Text(
                                      'قفل کودک',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                      ),
                                    ),
                                  if (security.input!.doorState ?? false)
                                    Text(
                                      'در باز',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                      ),
                                    ),
                                  if (security.input!.exitAlarmEg ?? false)
                                    Text(
                                      'هشدار خروج',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                      ),
                                    ),
                                  if (security.state == 3)
                                    Text(
                                      'برق روشن',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                      ),
                                    ),
                                  if (security.input!.hoodState ?? false)
                                    Text(
                                      'کاپوت باز',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                      ),
                                    ),
                                  if (security.input!.lockState ?? false)
                                    Text(
                                      'قفل',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                      ),
                                    ),
                                  if (security.input!.optionKey ?? false)
                                    Text(
                                      'کلید ترکیبی',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                      ),
                                    ),
                                  if (security.input!.shock ?? false)
                                    Text(
                                      'سنسور ضربه',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                      ),
                                    ),
                                  if (security.input!.trunkState ?? false)
                                    Text(
                                      'صندوق باز',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                      ),
                                    ),
                                  if (security.input!.ultra ?? false)
                                    Text(
                                      'سنسور چشمی',
                                      style: TextStyle(
                                        fontSize: size.width * .03,
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'کنترل های فعال',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: size.width * .03,
                                  fontFamily: 'YekanBakh-Regular',
                                  color: const Color(0xFF8D8D8D),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                security.typeSec != null
                                    ? security.typeSec == 0
                                        ? 'ریموت فیزیکی'
                                        : 'فاکسن'
                                    : 'نامشخص',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: size.width * .03,
                                  fontFamily: 'YekanBakh-Regular',
                                  color: const Color(0xFF565656),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'نحوه ایجاد',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: size.width * .03,
                                  fontFamily: 'YekanBakh-Regular',
                                  color: const Color(0xFF8D8D8D),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .035,
                  ),
                  Container(
                    height: size.height * .315,
                    padding: EdgeInsets.only(
                      left: size.width * .035,
                      right: size.width * .035,
                      top: size.height * .02,
                    ),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: -7,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Center(
                            child: Image.asset(
                              'assets/car/security_car.png',
                            ),
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFF70B7E1),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '  کیلومتر',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF757575),
                                        fontSize: size.width * .03,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * .01,
                                    ),
                                    Text(
                                      // TODO get from back
                                      AppUtil.replacePersianNumber(
                                        '0',
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF1C6D69),
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * .0325,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CarSpeedGauge(
                                  value: security.speed != null
                                      ? security.speed!.toDouble()
                                      : 0,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: FittedBox(
                                        child: Text(
                                          '   کیلومتر بر ساعت',
                                          style: TextStyle(
                                            fontFamily: 'YekanBakh-Regular',
                                            color: Color(0xFF757575),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * .01,
                                    ),
                                    Text(
                                      AppUtil.replacePersianNumber(
                                        security.speed != null
                                            ? security.speed.toString()
                                            : '0',
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF1C6D69),
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * .0325,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * .02,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
