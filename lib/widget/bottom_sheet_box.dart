import 'package:flutter/material.dart';
import 'package:foxenapp/controller/device_controller.dart';
import 'package:foxenapp/model/foxen_device.dart';
import 'package:foxenapp/util/app_theme.dart';
import 'package:foxenapp/util/device_field_extractor.dart';
import 'package:get/get.dart';

class BottomSheetBox {
  static Future<String> showDeviceList() async {
    final size = MediaQuery.of(Get.context!).size;
    final DeviceController deviceController = Get.find<DeviceController>();
    List<FoxenDevice> devices = deviceController.devices.value;
    return await Get.bottomSheet(
      backgroundColor: Colors.transparent,
      Container(
        height: size.height * .35,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
        ),
        child: devices.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.feed_rounded,
                    size: size.height * .1,
                    color: AppTheme.textFieldTextColor,
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  Text(
                    'دستگاهی یافت نشد',
                    style: TextStyle(
                      color: AppTheme.textFieldTextColor,
                      fontSize: size.width * .05,
                      fontFamily: 'YekanBakh-Bold',
                    ),
                  ),
                ],
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: size.height * .02,
                ),
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  String? phoneNumber = DeviceFieldExtractor.getCarSimNumber(
                    devices.elementAt(index),
                  );
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: phoneNumber != null
                          ? () {
                              Navigator.of(context).pop(phoneNumber);
                            }
                          : null,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * .0165,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: size.width * .05,
                            ),
                            Text(
                              phoneNumber ?? 'بدون شماره',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: const Color(0xFF189A93),
                                fontSize: size.width * .0325,
                                fontFamily: 'YekanBakh-Bold',
                              ),
                            ),
                            SizedBox(
                              width: size.width * .04,
                            ),
                            Expanded(
                              child: Text(
                                DeviceFieldExtractor.getCarName(
                                  devices.elementAt(index),
                                ),
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppTheme.textFieldTextColor,
                                  fontSize: size.width * .035,
                                  fontFamily: 'YekanBakh-Bold',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * .04,
                            ),
                            const Icon(
                              Icons.car_crash_rounded,
                              color: AppTheme.textFieldTextColor,
                            ),
                            SizedBox(
                              width: size.width * .04,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
