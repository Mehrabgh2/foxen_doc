import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:foxenapp/enum/support_tutorial_video_type.dart';
import 'package:foxenapp/modules/support/support_tutorial_videos/widget/support_tutorial_video_player.dart';
import 'package:foxenapp/util/constants.dart';
import 'package:foxenapp/widget/dialog_box.dart';
import 'package:foxenapp/widget/overlay_toast.dart';
import 'package:get/get.dart';

class SupportTutorialVideosController extends GetxController {
  RxList<double> downloadValues =
      RxList.generate(SupportTutorialVideoType.values.length, (index) => 0);
  RxList<CancelToken?> downloadCancelTokens = RxList.generate(
      SupportTutorialVideoType.values.length, (index) => CancelToken());

  void downloadFile(SupportTutorialVideoType type) async {
    try {
      Dio dio = Dio();
      File dir = File(getDownloadPath(type));
      if (await dir.exists()) {
        OverlayToast.showFailureMessage('فایل قبلا دانلود شده است');
      } else {
        downloadValues[type.index] = 1;
        downloadValues.refresh();
        await dio.download(getLink(type), dir.path,
            cancelToken: downloadCancelTokens.elementAt(type.index),
            onReceiveProgress: (received, total) {
          double downloadProgress =
              (received.toDouble() / total.toDouble()) * 100;
          downloadValues[type.index] = downloadProgress;
          downloadValues.refresh();
          if (downloadProgress == 100) {
            downloadValues[type.index] = 0;
            downloadValues.refresh();
            OverlayToast.showSuccessMessage('فایل با موفقیت دانلود شد');
          }
        });
      }
    } catch (ex) {
      downloadValues[type.index] = 0;
      downloadValues.refresh();
    }
  }

  void cancelDownload(SupportTutorialVideoType type) async {
    CancelToken? token = downloadCancelTokens.elementAt(type.index);
    if (token != null) {
      token.cancel();
      File deleteFile = File(getDownloadPath(type));
      if (await deleteFile.exists()) {
        await deleteFile.delete();
      }
      downloadValues[type.index] = 0;
      downloadValues.refresh();
      downloadCancelTokens[type.index] = CancelToken();
      downloadCancelTokens.refresh();
    }
  }

  void playFile(SupportTutorialVideoType type) {
    DialogBox.showVideoPlayer(
      context: Get.context!,
      title: getTitle(type),
      player: SupportTutorialVideoPlayer(
        link: getLink(type),
      ),
    );
  }

  String getTitle(SupportTutorialVideoType type) {
    switch (type) {
      case SupportTutorialVideoType.map:
        return 'نقشه';
      case SupportTutorialVideoType.security:
        return 'دزدگیر';
      case SupportTutorialVideoType.relay:
        return 'رله';
      case SupportTutorialVideoType.carSetting:
        return 'تنظیمات ماشین';
      case SupportTutorialVideoType.rabinSetting:
        return 'تنظیمات ردیاب رابین';
      case SupportTutorialVideoType.reporting:
        return 'گزارش گیری';
    }
  }

  String getDescription(SupportTutorialVideoType type) {
    switch (type) {
      case SupportTutorialVideoType.map:
        return 'استفاده از صفحه نقشه';
      case SupportTutorialVideoType.security:
        return 'ابزارها و کنترل های دزدگیر';
      case SupportTutorialVideoType.relay:
        return 'قطع و وصل کردن و تنظیمات رله';
      case SupportTutorialVideoType.carSetting:
        return 'قسمت های تنظیمات ماشین در صفحه ماشین';
      case SupportTutorialVideoType.rabinSetting:
        return 'فقط برای ردیاب های رابین در تنظیمات ماشین';
      case SupportTutorialVideoType.reporting:
        return 'نحوه گرفتن گزارش های مختلف';
    }
  }

  String getLink(SupportTutorialVideoType type) {
    switch (type) {
      case SupportTutorialVideoType.map:
        return '${Constants.SUPPORT_VIDEOS_BASE_URL}map.mp4';
      case SupportTutorialVideoType.security:
        return '${Constants.SUPPORT_VIDEOS_BASE_URL}security.mp4';
      case SupportTutorialVideoType.relay:
        return '${Constants.SUPPORT_VIDEOS_BASE_URL}relay_OtherCommands.mp4';
      case SupportTutorialVideoType.carSetting:
        return '${Constants.SUPPORT_VIDEOS_BASE_URL}setting.mp4';
      case SupportTutorialVideoType.rabinSetting:
        return '${Constants.SUPPORT_VIDEOS_BASE_URL}rabbinSetting.mp4';
      case SupportTutorialVideoType.reporting:
        return '${Constants.SUPPORT_VIDEOS_BASE_URL}report.mp4';
    }
  }

  String getDownloadPath(SupportTutorialVideoType type) {
    return '/storage/emulated/0/download/${getDescription(type)}.mp4';
  }
}
