import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../enum/command_subtype.dart';
import '../../../model/foxen_device.dart';
import '../../../widget/custom_svg_widget.dart';
import 'car_dont_have_security_card_view.dart';
import 'car_security_option.dart';
import 'car_simple_security_option.dart';

class CarSecurityCardView extends StatelessWidget {
  const CarSecurityCardView({
    required this.device,
    required this.onCommand,
    required this.hasSecurity,
    required this.onDontShowAgain,
    required this.onSetupSecurity,
    required this.onSecurityControlPressed,
    required this.isLoading,
    super.key,
  });

  final FoxenDevice device;
  final Function(FoxenDevice, CommandSubType) onCommand;
  final bool hasSecurity;
  final VoidCallback onDontShowAgain;
  final VoidCallback onSetupSecurity;
  final VoidCallback onSecurityControlPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height * .01),
      margin: EdgeInsets.symmetric(horizontal: size.width * .05),
      decoration: BoxDecoration(
        color: const Color(0xFFDEEDEC),
        borderRadius: BorderRadius.circular(14),
      ),
      width: size.width,
      height: size.height * .325,
      child: Obx(
        () {
          Rx(null).value;
          return Column(
            children: [
              Text(
                'دزدگیر',
                style: TextStyle(
                  fontFamily: 'YekanBakh-Bold',
                  color: const Color(0xFF189A93),
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * .0325,
                ),
              ),
              SizedBox(
                height: size.height * .005,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: size.height * .006,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * .035,
                              vertical: size.height * .02,
                            ),
                            width: size.width,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: CarSimpleSecurityOption(
                                        isLoading: isLoading,
                                        isActive:
                                            device.lastDeviceStatus != null &&
                                                    device.lastDeviceStatus!
                                                            .security !=
                                                        null
                                                ? device
                                                        .lastDeviceStatus!
                                                        .security!
                                                        .value
                                                        .state ==
                                                    1
                                                : false,
                                        title: 'قفل',
                                        icon: 'assets/car/mute_lock.svg',
                                        onPressed: (value) => onCommand(
                                            device, CommandSubType.lock),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * .035,
                                    ),
                                    Expanded(
                                      child: CarSimpleSecurityOption(
                                        isLoading: isLoading,
                                        isActive:
                                            device.lastDeviceStatus != null &&
                                                    device.lastDeviceStatus!
                                                            .security !=
                                                        null
                                                ? device
                                                        .lastDeviceStatus!
                                                        .security!
                                                        .value
                                                        .state ==
                                                    2
                                                : false,
                                        title: 'قفل با صدا',
                                        icon: 'assets/car/lock.svg',
                                        onPressed: (value) => onCommand(
                                            device, CommandSubType.lock),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * .035,
                                    ),
                                    Expanded(
                                      child: CarSimpleSecurityOption(
                                        isLoading: isLoading,
                                        isActive:
                                            device.lastDeviceStatus != null &&
                                                    device.lastDeviceStatus!
                                                            .security !=
                                                        null
                                                ? device
                                                        .lastDeviceStatus!
                                                        .security!
                                                        .value
                                                        .state ==
                                                    0
                                                : false,
                                        title: 'باز کردن قفل',
                                        icon: 'assets/car/unlock.svg',
                                        onPressed: (value) => onCommand(
                                            device, CommandSubType.unlock),
                                      ),
                                    ),
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                Material(
                                  shadowColor: const Color(0xFF189A93),
                                  elevation: 4,
                                  color: const Color(0xFF189A93),
                                  borderRadius: BorderRadius.circular(26),
                                  child: InkWell(
                                    onTap: onSecurityControlPressed,
                                    borderRadius: BorderRadius.circular(26),
                                    child: Container(
                                      height: size.height * .055,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(26),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'کنترل های دزدگیر',
                                            style: TextStyle(
                                              fontFamily: 'YekanBakh-Regular',
                                              color: const Color(0xFFF7F7F7),
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * .03,
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * .035,
                                          ),
                                          const CustomSvgWidget(
                                            'assets/car/security_control.svg',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CarSecurityOption(
                                        title: 'صندوق عقب',
                                        icon: 'assets/car/trunk.svg',
                                        text: 'باز کردن',
                                        isLoading: isLoading,
                                        isActive:
                                            device.lastDeviceStatus != null &&
                                                    device.lastDeviceStatus!
                                                            .security !=
                                                        null &&
                                                    device
                                                            .lastDeviceStatus!
                                                            .security!
                                                            .value
                                                            .input !=
                                                        null
                                                ? device
                                                        .lastDeviceStatus!
                                                        .security!
                                                        .value
                                                        .input!
                                                        .trunkState ??
                                                    false
                                                : false,
                                        onPressed: () => onCommand(
                                            device, CommandSubType.trunk),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * .035,
                                    ),
                                    Expanded(
                                      child: CarSecurityOption(
                                        title: 'فلاشر و آژیر',
                                        icon: 'assets/car/alarm.svg',
                                        text: 'روشن کردن',
                                        isLoading: isLoading,
                                        isActive:
                                            device.lastDeviceStatus != null &&
                                                    device.lastDeviceStatus!
                                                            .security !=
                                                        null &&
                                                    device
                                                            .lastDeviceStatus!
                                                            .security!
                                                            .value
                                                            .state !=
                                                        null
                                                ? device
                                                        .lastDeviceStatus!
                                                        .security!
                                                        .value
                                                        .state! ==
                                                    4
                                                : false,
                                        onPressed: () => onCommand(
                                            device, CommandSubType.alarm),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    if (!hasSecurity)
                      Positioned.fill(
                        child: CarDontHaveSecurityContainer(
                          onSetupSecurity: onSetupSecurity,
                          onDontShowAgain: onDontShowAgain,
                        ),
                      )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
