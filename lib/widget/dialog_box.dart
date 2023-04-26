import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import '../modules/profile/fingerprint/controller/fingerprint_controller.dart';
import 'custom_svg_widget.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class DialogBox {
  static void showInfoDialog({
    required BuildContext context,
    required String info,
  }) {
    final size = MediaQuery.of(context).size;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          content: Container(
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    ',,',
                    style: TextStyle(
                      height: .3,
                      fontSize: 50,
                      color: Color(0xFF189A93),
                      fontFamily: 'YekanBakh-Bold',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .03,
                  ),
                  child: Text(
                    info,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: size.width * .035,
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF565656),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: 180 * (math.pi / 180),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ',,',
                      style: TextStyle(
                        height: .3,
                        fontSize: 50,
                        color: Color(0xFF189A93),
                        fontFamily: 'YekanBakh-Bold',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: size.height * .01),
                height: size.height * .05,
                decoration: BoxDecoration(
                  color: const Color(0xFFBEE9E7),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFF828282),
                      spreadRadius: -5,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: const Color(0xFF828282).withAlpha(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * .075),
                    child: Text(
                      'متوجه شدم',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * .035,
                        fontFamily: 'YekanBakh-Bold',
                        color: const Color(0xFF189A93),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showChangeBookmarkDialog({
    required BuildContext context,
    required String prevCar,
    required String newCar,
    required VoidCallback confirmPressed,
  }) {
    final size = MediaQuery.of(context).size;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تغییر کند؟',
                style: TextStyle(
                  fontFamily: 'YekanBakh-Regular',
                  fontSize: size.width * .0275,
                  color: const Color(0xFF565656),
                ),
              ),
              Text(
                ' $newCar ',
                style: TextStyle(
                  fontFamily: 'YekanBakh-Bold',
                  fontSize: size.width * .03,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF565656),
                ),
              ),
              Text(
                'به',
                style: TextStyle(
                  fontFamily: 'YekanBakh-Bold',
                  fontSize: size.width * .0275,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF565656),
                ),
              ),
              Text(
                ' $prevCar ',
                style: TextStyle(
                  fontFamily: 'YekanBakh-Bold',
                  fontSize: size.width * .03,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF565656),
                ),
              ),
              Text(
                'ماشین اصلی از ',
                style: TextStyle(
                  fontFamily: 'YekanBakh-Regular',
                  fontSize: size.width * .0275,
                  color: const Color(0xFF565656),
                ),
              ),
            ],
          ),
          content: Text(
            'شما می توانید یک ماشین را به عنوان ماشین اصلی نشانه گذاری کنید',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width * .03,
              fontFamily: 'YekanBakh-Regular',
              color: const Color(0xFF8D8D8D),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .015),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9EBEC),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: Get.back,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'انصراف',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: const Color(0xFFF85763),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .035,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFBEE9E7),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          confirmPressed();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'نشانه گذاری',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: const Color(0xFF189A93),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showTurnOnRelayDialog({
    required BuildContext context,
    required String type,
    required String vehicle,
    required bool isOn,
    required bool isRelay,
    required VoidCallback confirmPressed,
  }) async {
    final size = MediaQuery.of(context).size;
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          content: Container(
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (isRelay && !isOn)
                  SizedBox(
                    height: size.height * .2,
                    child: const CustomSvgWidget(
                      'assets/car/red_danger.svg',
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'شود؟',
                        style: TextStyle(
                          fontSize: size.width * .03,
                          color: const Color(0xFF656565),
                          fontFamily: 'YekanBakh-Regular',
                        ),
                      ),
                      _textSpacer(size),
                      Text(
                        isRelay
                            ? isOn
                                ? 'وصل'
                                : 'قطع'
                            : isOn
                                ? 'فعال'
                                : 'غیرفعال',
                        style: TextStyle(
                          fontSize: size.width * .035,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF656565),
                          fontFamily: 'YekanBakh-Bold',
                        ),
                      ),
                      _textSpacer(size),
                      Text(
                        vehicle,
                        style: TextStyle(
                          fontSize: size.width * .03,
                          color: const Color(0xFF656565),
                          fontFamily: 'YekanBakh-Regular',
                        ),
                      ),
                      _textSpacer(size),
                      Text(
                        'برای',
                        style: TextStyle(
                          fontSize: size.width * .03,
                          color: const Color(0xFF656565),
                          fontFamily: 'YekanBakh-Regular',
                        ),
                      ),
                      _textSpacer(size),
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: size.width * .03,
                          color: const Color(0xFF656565),
                          fontFamily: 'YekanBakh-Regular',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .015),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9EBEC),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: Get.back,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'انصراف',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: const Color(0xFFF85763),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .035,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFBEE9E7),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: confirmPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '${isRelay ? isOn ? 'وصل' : 'قطع' : isOn ? 'فعال' : 'غیرفعال'} $type',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: const Color(0xFF189A93),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static void showTurnOnRelayWithSms({
    required BuildContext context,
    required VoidCallback confirmPressed,
    required VoidCallback secondConfirmPressed,
    required bool isMobile,
  }) {
    final size = MediaQuery.of(context).size;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              isMobile ? 'اینترنت تلفن همراه متصل نیست' : 'دستگاه متصل نیست',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'YekanBakh-Regular',
                fontSize: size.width * .0275,
                color: const Color(0xFF565656),
              ),
            ),
          ),
          content: Text(
            'آیا میخواهید دستور از طریق پیامک ارسال شود؟',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width * .03,
              fontFamily: 'YekanBakh-Regular',
              color: const Color(0xFF8D8D8D),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .015),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9EBEC),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: Get.back,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'انصراف',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: const Color(0xFFF85763),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .035,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFBEE9E7),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          confirmPressed();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'پیامک',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: const Color(0xFF189A93),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!isMobile)
                    SizedBox(
                      width: size.width * .035,
                    ),
                  if (!isMobile)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: size.height * .01),
                        height: size.height * .05,
                        decoration: BoxDecoration(
                          color: const Color(0xFFBEE9E7),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF828282),
                              spreadRadius: -5,
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            secondConfirmPressed();
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor:
                                const Color(0xFF828282).withAlpha(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'اپلیکیشن',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.width * .0315,
                              fontFamily: 'YekanBakh-Bold',
                              color: const Color(0xFF189A93),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static void showLogoutConfirmationDialog({
    required BuildContext context,
    required VoidCallback confirmPressed,
  }) {
    final size = MediaQuery.of(context).size;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'میخواهید از حساب کاربری خود خارج شوید؟',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width * .03,
              fontFamily: 'YekanBakh-Regular',
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8D8D8D),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .015),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFBEE9E7),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: Get.back,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'انصراف',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: const Color(0xFF189A93),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .035,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF85763),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          confirmPressed();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white.withAlpha(30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'خروج',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showTurnOnBiometricDialog() async {
    final FingerprintController fingerprintController =
        Get.find<FingerprintController>();
    final size = MediaQuery.of(Get.context!).size;
    await showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          content: Container(
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .03,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'در هنگام ورود',
                            style: TextStyle(
                              fontSize: size.width * .0275,
                              color: const Color(0xFF656565),
                              fontFamily: 'YekanBakh-Regular',
                            ),
                          ),
                          _textSpacer(size),
                          Text(
                            'حسگر اثر انگشت ',
                            style: TextStyle(
                              fontSize: size.width * .0325,
                              color: const Color(0xFF656565),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'YekanBakh-Bold',
                            ),
                          ),
                          _textSpacer(size),
                          Text(
                            'آیا مایل به استفاده از ',
                            style: TextStyle(
                              fontSize: size.width * .0275,
                              color: const Color(0xFF656565),
                              fontFamily: 'YekanBakh-Regular',
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'به اپلیکیشن هستید؟',
                        style: TextStyle(
                          fontSize: size.width * .0275,
                          color: const Color(0xFF656565),
                          fontFamily: 'YekanBakh-Regular',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .015),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9EBEC),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: Get.back,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'انصراف',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: const Color(0xFFF85763),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .035,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFF84C31E),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          await fingerprintController.turnOn();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'تایید',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showChangeOdometerDialog(
    String carName,
    String odometer,
    VoidCallback onConfirm,
  ) async {
    final size = MediaQuery.of(Get.context!).size;
    await showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          content: Container(
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'کیلومتر تغییر یابد؟',
                  style: TextStyle(
                    fontSize: size.width * .0275,
                    color: const Color(0xFF656565),
                    fontFamily: 'YekanBakh-Regular',
                  ),
                ),
                _textSpacer(size),
                Text(
                  odometer,
                  style: TextStyle(
                    fontSize: size.width * .0325,
                    color: const Color(0xFF656565),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'YekanBakh-Bold',
                  ),
                ),
                _textSpacer(size),
                Text(
                  ' به',
                  style: TextStyle(
                    fontSize: size.width * .0275,
                    color: const Color(0xFF656565),
                    fontFamily: 'YekanBakh-Regular',
                  ),
                ),
                _textSpacer(size),
                Text(
                  carName,
                  style: TextStyle(
                    fontSize: size.width * .0275,
                    color: const Color(0xFF656565),
                    fontFamily: 'YekanBakh-Regular',
                  ),
                ),
                _textSpacer(size),
                Text(
                  'مسافت طی شده  ',
                  style: TextStyle(
                    fontSize: size.width * .0275,
                    color: const Color(0xFF656565),
                    fontFamily: 'YekanBakh-Regular',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .015),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9EBEC),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: Get.back,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'انصراف',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: const Color(0xFFF85763),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .035,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFF84C31E),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          onConfirm();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'تایید',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static void showCarCreatedDialog({
    required BuildContext context,
    required String carName,
  }) {
    final size = MediaQuery.of(context).size;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          content: Container(
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .02,
                ),
                const Center(
                  child: CustomSvgWidget('assets/car/check.svg'),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'به لیست ماشین ها اضافه شد ',
                      style: TextStyle(
                        fontSize: size.width * .0315,
                        fontFamily: 'YekanBakh-Bold',
                        color: const Color(0xFF84C31E),
                      ),
                    ),
                    Text(
                      carName,
                      style: TextStyle(
                        fontFamily: 'YekanBakh-Bold',
                        fontSize: size.width * .0315,
                        color: const Color(0xFF84C31E),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                SizedBox(
                  width: size.width,
                  child: const DottedLine(
                    dashColor: Color(0xFFE0E0E0),
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'را در تنظیمات ثبت کنید ',
                      style: TextStyle(
                        fontSize: size.width * .03,
                        fontFamily: 'YekanBakh-Regular',
                        color: const Color(0xFF565656),
                      ),
                    ),
                    Text(
                      carName,
                      style: TextStyle(
                        fontFamily: 'YekanBakh-Regular',
                        fontSize: size.width * .03,
                        color: const Color(0xFF565656),
                      ),
                    ),
                    Text(
                      ' می توانید اطلاعات تکمیلی',
                      style: TextStyle(
                        fontSize: size.width * .03,
                        fontFamily: 'YekanBakh-Regular',
                        color: const Color(0xFF565656),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .015),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFF84C31E),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'تایید',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<DateTime?> showTimePickerDialog({
    required BuildContext context,
  }) async {
    final size = MediaQuery.of(context).size;
    DateTime? selectedTime = DateTime.now();
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          content: Container(
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .03,
                ),
                TimePickerSpinner(
                  is24HourMode: true,
                  time: selectedTime,
                  normalTextStyle: TextStyle(
                    fontSize: size.width * .04,
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF565656),
                  ),
                  highlightedTextStyle: TextStyle(
                    fontSize: size.width * .05,
                    fontFamily: 'YekanBakh-Bold',
                    color: const Color(0xFF189A93),
                  ),
                  spacing: size.height * .01,
                  itemHeight: size.height * .04,
                  isForce2Digits: true,
                  isShowSeconds: false,
                  onTimeChange: (time) {
                    selectedTime = time;
                  },
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .015),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9EBEC),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: Get.back,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'انصراف',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .0315,
                            fontFamily: 'YekanBakh-Bold',
                            color: const Color(0xFFF85763),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .035,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFF189A93),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context, selectedTime);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'تایید',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .03,
                            fontFamily: 'YekanBakh-Bold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<DateTime?> showVideoPlayer({
    required BuildContext context,
    required String title,
    required Widget player,
  }) async {
    final size = MediaQuery.of(context).size;
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          content: Container(
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * .05,
                    fontFamily: 'YekanBakh-Bold',
                    color: const Color(0xFF189A93),
                  ),
                ),
                SizedBox(height: size.height * .01),
                Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: size.height * .055,
                        height: size.height * .055,
                        child: SpinKitFadingCircle(
                          color: Colors.blue,
                          size: size.height * .055,
                        ),
                      ),
                    ),
                    player,
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .015),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height * .01),
                      height: size.height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFF189A93),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF828282),
                            spreadRadius: -5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: Get.back,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor:
                              const Color(0xFF828282).withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'تایید',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .03,
                            fontFamily: 'YekanBakh-Bold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget _textSpacer(Size size) => SizedBox(width: size.width * .0085);
}
