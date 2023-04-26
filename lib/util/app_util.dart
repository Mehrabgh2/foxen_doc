import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foxenapp/enum/validator_enum.dart';
import 'package:get/get.dart';

import '../controller/foxen_user_controller.dart';
import '../enum/server_error_type.dart';
import 'server_messages.dart';

class AppUtil {
  static final AppUtil _singleton = AppUtil._internal();
  factory AppUtil() {
    return _singleton;
  }
  AppUtil._internal();

  final FoxenUserController foxenUserController =
      Get.find<FoxenUserController>();

  static removeFocus() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  Map<String, String>? getHeaderWithToken() {
    return foxenUserController.user.value != null &&
            foxenUserController.user.value!.token != null &&
            foxenUserController.user.value!.token!.isNotEmpty
        ? {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${foxenUserController.user.value!.token}',
          }
        : null;
  }

  Map<String, String> getHeader() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
  }

  static String getCodeErrorMessage(int code) =>
      serverErrorsCode[code] ?? 'Error code : $code';

  static String getMessageErrorMessage(
      String serverMessage, ServerErrorType type) {
    switch (type) {
      case ServerErrorType.auth:
        return authServerErrorsStrings[serverMessage] ?? serverMessage;
      case ServerErrorType.car:
        return carServerErrorsStrings[serverMessage] ?? serverMessage;
    }
  }

  static String replacePersianNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], persian[i]);
    }
    return input;
  }

  static bool getBool(String? number, [bool isReverse = false]) => isReverse
      ? !(number != null ? int.parse(number) == 1 : false)
      : (number != null ? int.parse(number) == 1 : false);

  static List<String> getBinList(num hex) {
    int decimal = int.parse(hex.toString());
    String bin = '';
    while (decimal > 0) {
      bin = bin + (decimal % 2).toString();
      decimal = (decimal / 2).floor();
    }
    return bin.split('');
  }

  static int convertBinToDecimal(String bin) {
    return int.parse(("0$bin")
        .codeUnits
        .map((x) => x.toRadixString(2).padLeft(8, '0'))
        .join());
  }

  static int binToDec(int binary) {
    int temp = binary;
    int decimal = 0;
    int i = 0;
    while (temp > 0) {
      int rem = temp % 10;
      decimal = decimal + (rem * pow(2, i)) as int;
      temp = (temp ~/ 10);
      i++;
    }
    return decimal;
  }

  static String getAuthValidationError(
      AuthValidateEnum validate, String param, int min, int max,
      [bool isSignup = false]) {
    switch (validate) {
      case AuthValidateEnum.success:
        return 'success';
      case AuthValidateEnum.empty:
        return isSignup
            ? '.لطفا $param را وارد کنید'
            : '.لطفا $param خود را وارد کنید';
      case AuthValidateEnum.minLength:
        return isSignup && min == 11 && max == 11
            ? '.شماره تلفن همراه صحیح، 11 رقمی است'
            : '.$param حداقل باید $min کاراکتر باشد';
      case AuthValidateEnum.maxLength:
        return '.$param حداکثر باید $max کاراکتر باشد';
      case AuthValidateEnum.wrongPassword:
        return '.رمز عبور باید شامل حروف و اعداد انگلیسی باشد';
      case AuthValidateEnum.wrongRepeatPassword:
        return '.تکرار رمز عبور باید شامل حروف و اعداد انگلیسی باشد';
      case AuthValidateEnum.wrongPhone:
        return '.شماره موبایل وارد شده صحیح نمی باشد';
      case AuthValidateEnum.wrongOTP:
        return '.کد تایید وارد شده صحیح نمی باشد';
      case AuthValidateEnum.wrongJustEnglish:
        return '.$param وارد شده صحیح نیست';
    }
  }

  static Future<String> readJsonAssets(String path) async {
    return await DefaultAssetBundle.of(Get.context!).loadString(path);
  }

  static const persianMonths = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];
}
