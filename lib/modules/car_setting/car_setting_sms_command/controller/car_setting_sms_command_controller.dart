import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import '../../../../enum/car_setting_sms_command_type.dart';
import '../../../../model/foxen_device.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/overlay_toast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CarSettingSmsCommandController extends GetxController {
  CarSettingSmsCommandController({required this.device});
  final FoxenDevice device;

  void onSend(CarSettingSmsCommandType command) async {
    String? phoneNumber = DeviceFieldExtractor.getCarSimNumber(device);
    if (phoneNumber == null) {
      OverlayToast.showFailureMessage('شماره ای برای دستگاه ثبت نشده است');
      return;
    }
    bool permission = await getSmsPermission();
    if (permission) {
      try {
        String result = await sendSMS(
          message: getCommand(command),
          recipients: [phoneNumber],
          sendDirect: true,
        ).catchError(
          (onError) {
            OverlayToast.showFailureMessage('ارسال دستور با شکست مواجه شد');
          },
        );
        if (result == 'SMS Sent!') {
          OverlayToast.showSuccessMessage('دستور با موفقیت ارسال شد');
        }
      } catch (ex) {
        OverlayToast.showFailureMessage('ارسال دستور با شکست مواجه شد');
      }
    }
  }

  Future<bool> getSmsPermission() async {
    try {
      return await Permission.sms.request().isGranted;
    } catch (ex) {
      return Future.value(false);
    }
  }

  void copyCommand(CarSettingSmsCommandType command) async {
    await Clipboard.setData(ClipboardData(text: getCommand(command)));
    OverlayToast.showSuccessMessage('دستور با موفقیت کپی شد');
  }

  String getTitle(CarSettingSmsCommandType type) {
    switch (type) {
      case CarSettingSmsCommandType.turnOffRelay:
        return 'قطع جریان برق';
      case CarSettingSmsCommandType.turnOnRelay:
        return 'وصل جریان برق';
      case CarSettingSmsCommandType.turnOffFuel:
        return 'قطع جریان سوخت';
      case CarSettingSmsCommandType.turnOnFuel:
        return 'وصل جریان سوخت';
      case CarSettingSmsCommandType.getAllData:
        return 'دریافت اطلاعات کلی ردیاب';
      case CarSettingSmsCommandType.getGpsData:
        return 'دریافت اطلاعات GPS';
      case CarSettingSmsCommandType.getSimCharge:
        return 'دریافت میزان اعتبار سیمکارت';
      case CarSettingSmsCommandType.resetDevice:
        return 'فرمت کردن حافظه ذخیره سازی ردیاب';
    }
  }

  String getCommand(CarSettingSmsCommandType type) {
    switch (type) {
      case CarSettingSmsCommandType.turnOffRelay:
        return 'STOPCAR==1';
      case CarSettingSmsCommandType.turnOnRelay:
        return 'STOPCAR==0';
      case CarSettingSmsCommandType.turnOffFuel:
        return 'SPARERELAY==1';
      case CarSettingSmsCommandType.turnOnFuel:
        return 'SPARERELAY==0';
      case CarSettingSmsCommandType.getAllData:
        return 'REPORTALL??';
      case CarSettingSmsCommandType.getGpsData:
        return 'REPORTGPS??';
      case CarSettingSmsCommandType.getSimCharge:
        return 'SYSCREDIT??';
      case CarSettingSmsCommandType.resetDevice:
        return 'SYSUSDFORMAT==1';
    }
  }
}
