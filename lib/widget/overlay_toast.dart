import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

class OverlayToast {
  static void showSuccessMessage(String text) {
    showSimpleNotification(
      Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: Get.width * .03,
            fontFamily: 'YekanBakh-Regular',
            color: Colors.white,
          ),
        ),
      ),
      background: Colors.green,
    );
  }

  static void showFailureMessage(String text) {
    showSimpleNotification(
      Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: Get.width * .03,
            fontFamily: 'YekanBakh-Regular',
            color: Colors.white,
          ),
        ),
      ),
      background: Colors.red,
    );
  }
}
