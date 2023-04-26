import 'dart:async';
import 'package:flutter/material.dart';
import '../controller/authentication_controller.dart';
import '../../../util/app_theme.dart';
import '../../../util/app_util.dart';
import 'package:get/state_manager.dart';

class CountDownTimer extends StatelessWidget {
  CountDownTimer({required this.onFinish, super.key});
  final VoidCallback onFinish;
  Timer? countdownTimer;
  Rx<Duration> myDuration = Rx(const Duration(
    seconds: AuthenticationController.countdownTime,
  ));

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    if (countdownTimer != null && countdownTimer!.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        countdownTimer!.cancel();
      });
    }
  }

  void resetTimer() {
    stopTimer();
    myDuration.value = const Duration(
      seconds: AuthenticationController.countdownTime,
    );
    myDuration.refresh();
    startTimer();
  }

  void setCountDown() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final seconds = myDuration.value.inSeconds - 1;
      if (seconds < 0) {
        onFinish();
        countdownTimer!.cancel();
      } else {
        myDuration.value = Duration(seconds: seconds);
        myDuration.refresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String strDigits(int n) => n.toString().padLeft(2, '0');
    return Obx(
      () {
        final minutes = strDigits(myDuration.value.inMinutes.remainder(60));
        final seconds = strDigits(myDuration.value.inSeconds.remainder(60));
        return Text(
          AppUtil.replacePersianNumber('$minutes:$seconds'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'YekanBakh-Regular',
            color: AppTheme.hintColor,
            fontWeight: FontWeight.bold,
            fontSize: size.width * .03,
          ),
        );
      },
    );
  }
}
