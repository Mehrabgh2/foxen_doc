import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../controller/device_controller.dart';
import '../../../model/foxen_device.dart';
import '../../../util/app_util.dart';
import '../../../util/device_field_extractor.dart';
import '../../../widget/custom_border_switch.dart';
import '../../../widget/custom_svg_widget.dart';
import '../../bottom_navigation/widget/custom_bottom_navigation.dart';
import '../controller/custom_map_controller.dart';

class MapControlBottomSheet extends StatelessWidget {
  const MapControlBottomSheet({
    required this.device,
    required this.mapController,
    required this.deviceController,
    super.key,
  });

  final FoxenDevice device;
  final CustomMapController mapController;
  final DeviceController deviceController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Container(
        padding: EdgeInsets.only(
          left: size.width * .05,
          right: size.width * .05,
          top: size.height * .005,
          bottom: size.height * .015 + CustomBottomNavigation.height,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: 0,
                  child: Text(
                    DeviceFieldExtractor.getCarName(device),
                    style: TextStyle(
                      fontSize: size.width * .0375,
                      fontFamily: 'YekanBakh-Bold',
                      color: const Color(0xFF189A93),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: mapController.onMapClick,
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFFE9B4B8),
                  ),
                ),
                Text(
                  DeviceFieldExtractor.getCarName(device),
                  style: TextStyle(
                    fontSize: size.width * .0375,
                    fontFamily: 'YekanBakh-Bold',
                    color: const Color(0xFF189A93),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'آخرین به روزرسانی موقعیت',
                      style: TextStyle(
                        fontSize: size.width * .03,
                        fontFamily: 'YekanBakh-Regular',
                        color: const Color(0xFF979797),
                      ),
                    ),
                    device.lastDeviceStatus != null &&
                            device.lastDeviceStatus!.track != null &&
                            device.lastDeviceStatus!.track!.value
                                    .recievedTimestamp !=
                                null
                        ? getDate(
                            device.lastDeviceStatus!.track!.value
                                .recievedTimestamp!
                                .toInt(),
                          )
                        : Text(
                            'نامشخص',
                            style: TextStyle(
                              fontSize: size.width * .03,
                              fontFamily: 'YekanBakh-Regular',
                              color: const Color(0xFF979797),
                            ),
                          ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF828282),
                        spreadRadius: -7,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width * .02,
                      ),
                      Text(
                        DeviceFieldExtractor.getIsCarAccOn(device)
                            ? 'کیلومتر بر ساعت'
                            : 'ساعت',
                        style: TextStyle(
                          fontSize: size.width * .03,
                          fontFamily: 'YekanBakh-Regular',
                          color: const Color(0xFF828282),
                        ),
                      ),
                      SizedBox(
                        width: size.width * .01,
                      ),
                      Text(
                        DeviceFieldExtractor.getIsCarAccOn(device)
                            ? DeviceFieldExtractor.getCarSpeed(device)
                                .toString()
                            : AppUtil.replacePersianNumber(
                                DateTime.now()
                                    .difference(DateTime.fromMillisecondsSinceEpoch(
                                        (DeviceFieldExtractor.getIsCarAccOn(
                                                        device)
                                                    ? device.lastDeviceStatus
                                                            ?.lastAccOn ??
                                                        DateTime.now()
                                                                .millisecondsSinceEpoch /
                                                            1000
                                                    : device.lastDeviceStatus
                                                            ?.lastAccOff ??
                                                        DateTime.now()
                                                                .millisecondsSinceEpoch /
                                                            1000)
                                                .toInt() *
                                            1000))
                                    .inHours
                                    .toString(),
                              ),
                        style: TextStyle(
                            fontSize: size.width * .035,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'YekanBakh-Regular',
                            color: DeviceFieldExtractor.getIsCarAccOn(device)
                                ? const Color(0xFF84C31E)
                                : const Color(0xFF828282)),
                      ),
                      SizedBox(
                        width: size.width * .01,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * .0065,
                          horizontal: size.width * .03,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: DeviceFieldExtractor.getIsCarAccOn(device)
                                ? const Color(0xFF84C31E)
                                : const Color(0xFF828282)),
                        child: Text(
                          DeviceFieldExtractor.getIsCarAccOn(device)
                              ? 'روشن'
                              : 'خاموش',
                          style: TextStyle(
                            fontSize: size.width * .03,
                            fontFamily: 'YekanBakh-Regular',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * .0175,
            ),
            _divider(size.width * .85),
            SizedBox(
              height: size.height * .0175,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
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
                        deviceController.navigateToDevice(context, device);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: const Color(0xFF828282).withAlpha(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'من تا ماشین',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.width * .035,
                                fontFamily: 'YekanBakh-Bold',
                                color: const Color(0xFF189A93),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.width * .06,
                            width: size.width * .06,
                            child: const FittedBox(
                              child:
                                  CustomSvgWidget('assets/map/me_to_car.svg'),
                            ),
                          ),
                          SizedBox(
                            width: size.width * .015,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                if (DeviceFieldExtractor.getRelayShowInMapScreen(device))
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * .03,
                        ),
                        Expanded(
                          child: Container(
                            height: size.height * .05,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9E7DC),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFF828282),
                                  spreadRadius: -7,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: size.height * .05,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'قطع',
                                          style: TextStyle(
                                            fontSize: size.width * .0285,
                                            fontFamily: 'YekanBakh-Regular',
                                            color: const Color(0xFF828282),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * .01,
                                        ),
                                        CustomBorderSwitch(
                                          value: DeviceFieldExtractor
                                              .getMapRelayOn(device),
                                          onPressed: () => deviceController
                                              .switchMapRelay(context, device),
                                        ),
                                        SizedBox(
                                          width: size.width * .01,
                                        ),
                                        Text(
                                          'وصل',
                                          style: TextStyle(
                                            fontSize: size.width * .0285,
                                            fontFamily: 'YekanBakh-Regular',
                                            color: const Color(0xFF828282),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .015,
                                ),
                                SizedBox(
                                  width: size.width * .075,
                                  height: size.height * .05,
                                  child: Center(
                                    child: Text(
                                      DeviceFieldExtractor
                                          .getMapRelayTypeString(device),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'YekanBakh-Regular',
                                        fontSize: 7,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF5B5746),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .015,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: size.height * .0175,
            ),
            _divider(size.width * .85),
            SizedBox(
              height: size.height * .0175,
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        // TODO
                      },
                      child: Container(
                        height: size.height * .05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.5,
                            color: const Color(0xFFF7F7F7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * .015,
                            ),
                            const Icon(
                              Icons.chevron_left,
                              color: Color(0xFF189A93),
                            ),
                            Expanded(
                              child: Text(
                                'گزارش گیری',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.width * .03,
                                  fontFamily: 'YekanBakh-Regular',
                                  color: const Color(0xFF32769E),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.width * .06,
                              width: size.width * .06,
                              child: const FittedBox(
                                child: CustomSvgWidget('assets/map/report.svg'),
                              ),
                            ),
                            SizedBox(
                              width: size.width * .03,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * .03,
                ),
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        // TODO
                      },
                      child: Container(
                        height: size.height * .05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.5,
                            color: const Color(0xFFF7F7F7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * .015,
                            ),
                            const Icon(
                              Icons.chevron_left,
                              color: Color(0xFF189A93),
                            ),
                            Expanded(
                              child: Text(
                                'سرویس های ماشین',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.width * .03,
                                  fontFamily: 'YekanBakh-Regular',
                                  color: const Color(0xFF32769E),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.width * .06,
                              width: size.width * .06,
                              child: const FittedBox(
                                child:
                                    CustomSvgWidget('assets/map/service.svg'),
                              ),
                            ),
                            SizedBox(
                              width: size.width * .03,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _divider(double width) {
    return Container(
      color: const Color(0xFFF7F7F7),
      height: 2,
      width: width,
    );
  }

  Widget getDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    Jalali shamsiDate = Jalali.fromDateTime(date);
    int day = shamsiDate.day;
    int hour = shamsiDate.hour;
    int minute = shamsiDate.minute;
    String hourString = hour.toString().padLeft(2, '0');
    String minuteString = minute.toString().padLeft(2, '0');
    String month = AppUtil.persianMonths.elementAt(shamsiDate.month - 1);
    return Row(
      children: [
        Text(
          AppUtil.replacePersianNumber('$hourString:$minuteString'),
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'YekanBakh-Bold',
            color: Color(0xFF565656),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          month,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'YekanBakh-Bold',
            color: Color(0xFF565656),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          AppUtil.replacePersianNumber(day.toString()),
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'YekanBakh-Bold',
            color: Color(0xFF565656),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
