import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foxenapp/util/device_field_extractor.dart';
import 'car_info_security_option.dart';
import '../../../model/foxen_device.dart';
import '../../../util/app_theme.dart';
import '../../../widget/custom_svg_widget.dart';
import '../../../modules/car_setting/car_setting_edit_relay/screen/car_setting_edit_relay_screen.dart';
import 'package:get/get.dart';

class CarSecondCardView extends StatelessWidget {
  const CarSecondCardView({
    required this.device,
    required this.callDevice,
    required this.onRelayAlarmPressed,
    required this.onMovementAlarmPressed,
    required this.relay,
    required this.onRelayPressed,
    this.onRelayInfoPressed,
    required this.onCallInfoPressed,
    required this.isRelayOn,
    required this.showRelayAlarm,
    required this.showMovementAlarm,
    required this.isRelayAlarmOn,
    required this.isMovementAlarmOn,
    required this.isLoading,
    required this.isRelayAlarmLoading,
    required this.isMovementAlarmLoading,
    super.key,
  });

  final FoxenDevice device;
  final Function(FoxenDevice) callDevice;
  final Function(FoxenDevice, bool) onRelayAlarmPressed;
  final Function(FoxenDevice, bool) onMovementAlarmPressed;
  final String relay;
  final Function(bool) onRelayPressed;
  final VoidCallback? onRelayInfoPressed;
  final VoidCallback onCallInfoPressed;
  final bool isRelayOn;
  final bool showRelayAlarm;
  final bool showMovementAlarm;
  final bool isRelayAlarmOn;
  final bool isMovementAlarmOn;
  final bool isLoading;
  final bool isRelayAlarmLoading;
  final bool isMovementAlarmLoading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(
        vertical: size.height * .01,
        horizontal: size.width * .035,
      ),
      margin: EdgeInsets.symmetric(horizontal: size.width * .05),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE2E2E2),
          ),
          BoxShadow(
            color: Colors.white,
            spreadRadius: 2.0,
            blurRadius: 20.0,
          ),
        ],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 6,
                child: CarInfoSecurityOption(
                  isLargeSize: true,
                  title: relay,
                  isLoading: isLoading,
                  isActive: true,
                  onPressed: null,
                  onInfoPressed: onRelayInfoPressed,
                  onEdit: DeviceFieldExtractor.deviceIsRabin(device)
                      ? () {
                          Get.to(
                            () => CarSettingEditRelayScreen(device: device),
                            transition: Transition.rightToLeft,
                          );
                        }
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .035,
                      vertical: size.height * .0075,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Material(
                                  elevation: 4,
                                  shadowColor: const Color(0xFFE2E2E2),
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () => onRelayPressed(false),
                                    borderRadius: BorderRadius.circular(14),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * .02,
                                        vertical: size.height * .01,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.flash_auto,
                                            color: isRelayOn
                                                ? const Color(0xFF565656)
                                                : AppTheme.errorTextColor,
                                            size:
                                                (size.height / size.width) * 8,
                                          ),
                                          SizedBox(
                                            height: size.height * .01,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        size.height * .0025,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: isRelayOn
                                                        ? const Color(
                                                            0xFF565656)
                                                        : AppTheme
                                                            .errorTextColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    'قطع',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * .0285,
                                                      fontFamily:
                                                          'YekanBakh-Regular',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .05,
                              ),
                              Expanded(
                                child: Material(
                                  elevation: 4,
                                  shadowColor: const Color(0xFFE2E2E2),
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () => onRelayPressed(true),
                                    borderRadius: BorderRadius.circular(14),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * .02,
                                        vertical: size.height * .01,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.flash_auto,
                                            color: isRelayOn
                                                ? AppTheme.errorTextColor
                                                : const Color(0xFF565656),
                                            size:
                                                (size.height / size.width) * 8,
                                          ),
                                          SizedBox(
                                            height: size.height * .01,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        size.height * .0025,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: isRelayOn
                                                        ? AppTheme
                                                            .errorTextColor
                                                        : const Color(
                                                            0xFF565656),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    'وصل',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * .0285,
                                                      fontFamily:
                                                          'YekanBakh-Regular',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .0085,
                        ),
                        FittedBox(
                          child: Text(
                            '.در حال حاضر $relay خودرو ${isRelayOn ? "وصل" : "قطع"} می باشد',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'YekanBakh-Regular',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF565656),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * .035,
              ),
              Expanded(
                flex: 4,
                child: CarInfoSecurityOption(
                  isLargeSize: true,
                  title: 'تماس تلفنی',
                  isLoading: isLoading,
                  isActive: true,
                  onPressed: () => callDevice(device),
                  onInfoPressed: onCallInfoPressed,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: isLoading ? null : () => callDevice(device),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * .05,
                              height: size.width * .05,
                              child: const CustomSvgWidget(
                                'assets/car/call_device.svg',
                                color: Color(0xFF565656),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Text(
                              'برقراری تماس با ماشین',
                              style: TextStyle(
                                fontFamily: 'YekanBakh-Regular',
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * .0235,
                                color: const Color(0xFF565656),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * .005,
          ),
          if (showMovementAlarm)
            Column(
              children: [
                SizedBox(
                  height: size.height * .005,
                ),
                _optionRow(
                  size,
                  'هشدار حرکت ماشین',
                  isMovementAlarmOn,
                  (value) {
                    onMovementAlarmPressed(device, value);
                  },
                  isMovementAlarmLoading,
                ),
              ],
            ),
          if (showRelayAlarm)
            Column(
              children: [
                SizedBox(
                  height: size.height * .005,
                ),
                _optionRow(
                  size,
                  'هشدار روشن شدن ماشین',
                  isRelayAlarmOn,
                  (value) {
                    onRelayAlarmPressed(device, value);
                  },
                  isRelayAlarmLoading,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _optionRow(Size size, String text, bool value,
      Function(bool) onPressed, bool isLoading) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IgnorePointer(
            ignoring: isLoading,
            child: Opacity(
              opacity: isLoading ? .25 : 1,
              child: CupertinoSwitch(
                value: value,
                onChanged: onPressed,
                activeColor: const Color(0xFF189A93),
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'YekanBakh-Regular',
              color: const Color(0xFF565656),
              fontSize: size.width * .0325,
            ),
          ),
        ],
      ),
    );
  }
}
