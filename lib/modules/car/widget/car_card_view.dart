import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import '../../../model/foxen_device.dart';
import '../../../util/app_util.dart';
import '../../../util/device_field_extractor.dart';
import '../../../widget/custom_svg_widget.dart';
import '../../../widget/max_length_text.dart';
import 'package:segment_display/segment_display.dart';
import 'dart:math' as math;
import 'package:shamsi_date/shamsi_date.dart';

class CarCardView extends StatelessWidget {
  const CarCardView({
    required this.device,
    required this.onBookmarkPressed,
    Key? key,
  }) : super(key: key);

  final FoxenDevice device;
  final Function(FoxenDevice) onBookmarkPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () {
        Rx(null).value;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFDCDACB).withAlpha(100),
                const Color(0xFFDCDACB).withAlpha(50)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          margin: const EdgeInsets.all(5),
          child: BlurryContainer(
            padding: EdgeInsets.zero,
            color: Colors.transparent,
            blur: 12,
            borderRadius: BorderRadius.circular(18),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * .035),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(),
                                  MaxLengthText(
                                    DeviceFieldExtractor.getCarName(device),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF32769E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * .035,
                                    ),
                                    maxLength: 12,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: size.width * .01,
                              ),
                              DeviceFieldExtractor.getDeviceOnlineStatus(device)
                                  ? const Icon(
                                      Icons.wifi_rounded,
                                      color: Color(0xFF84C31E),
                                    )
                                  : Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: const Icon(
                                        Icons.wifi_off_rounded,
                                        color: Color(0xFFF85763),
                                      ),
                                    )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(),
                                  getDate(
                                    device.lastDeviceStatus != null &&
                                            device.lastDeviceStatus!.security !=
                                                null &&
                                            device.lastDeviceStatus!.security!
                                                    .value.recievedTimestamp !=
                                                null
                                        ? device.lastDeviceStatus!.security!
                                                .value.recievedTimestamp!
                                                .toInt() *
                                            1000
                                        : device.lastDeviceStatus != null &&
                                                device.lastDeviceStatus!
                                                        .linkTimestamp !=
                                                    null
                                            ? device.lastDeviceStatus!
                                                .linkTimestamp!
                                                .toInt()
                                            : null,
                                    size,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: size.width * .035,
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: InkWell(
                                  onTap: () {
                                    if (device.vehicle?.value.bookmark ==
                                        null) {
                                      onBookmarkPressed(device);
                                    } else {
                                      if (device.vehicle != null &&
                                          !device
                                              .vehicle!.value.bookmark!.value) {
                                        onBookmarkPressed(device);
                                      }
                                    }
                                  },
                                  child: CustomSvgWidget(
                                    device.vehicle != null &&
                                            device.vehicle!.value.bookmark !=
                                                null &&
                                            device
                                                .vehicle!.value.bookmark!.value
                                        ? 'assets/car/bookmark_selected.svg'
                                        : 'assets/car/bookmark_unselected.svg',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Center(
                    child: Image.asset(
                      DeviceFieldExtractor.getCarImage(device),
                    ),
                  ),
                ),
                const DottedLine(
                  dashColor: Color(0xFF70B7E1),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * .035),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height * .0015,
                                  horizontal: size.width * .035,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: DeviceFieldExtractor.getIsCarAccOn(
                                            device)
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
                              SizedBox(
                                height: size.height * .0035,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppUtil.replacePersianNumber(
                                        DeviceFieldExtractor.getIsCarAccOn(
                                                device)
                                            ? DeviceFieldExtractor.getCarSpeed(
                                                    device)
                                                .toString()
                                            : '0'),
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF189A93),
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * .0325,
                                    ),
                                  ),
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
                                    width: size.width * .02,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: SevenSegmentDisplay(
                              characterSpacing: 4,
                              value: DeviceFieldExtractor.getIsCarAccOn(device)
                                  ? DeviceFieldExtractor.getCarSpeed(device)
                                      .toString()
                                  : '0',
                              size: 4,
                              backgroundColor: Colors.transparent,
                              segmentStyle: DefaultSegmentStyle(
                                enabledColor: const Color(0xFF189A93),
                                disabledColor:
                                    const Color(0xFF189A93).withOpacity(0.2),
                                segmentBaseSize: const Size(1, 3),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'کارکرد',
                                style: TextStyle(
                                  fontFamily: 'YekanBakh-Regular',
                                  color: const Color(0xFF8D8D8D),
                                  fontSize: size.width * .0275,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: size.height * .003,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppUtil.replacePersianNumber(
                                      DeviceFieldExtractor.getCarOdometer(
                                          device),
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF189A93),
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * .0325,
                                    ),
                                  ),
                                  Text(
                                    '  کیلومتر',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF757575),
                                      fontSize: size.width * .025,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
          ),
        );
      },
    );
  }

  Widget getDate(int? timestamp, Size size) {
    if (timestamp == null) {
      return const SizedBox();
    }
    DateTime date = DateTime.fromMillisecondsSinceEpoch((timestamp).floor());
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
        Text(
          AppUtil.replacePersianNumber('$hourString:$minuteString'),
          style: TextStyle(
            fontSize: size.width * .03,
            fontFamily: 'YekanBakh-Bold',
            color: const Color(0xFF8D8D8D),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: size.width * .025),
        Text(
          AppUtil.replacePersianNumber('$dayString\\$month\\$year'),
          style: TextStyle(
            fontSize: size.width * .03,
            fontFamily: 'YekanBakh-Bold',
            color: const Color(0xFF8D8D8D),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
