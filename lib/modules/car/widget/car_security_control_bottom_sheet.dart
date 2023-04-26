import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/custom_border_switch.dart';
import '../../../widget/custom_svg_widget.dart';
import '../../../widget/dialog_box.dart';
import '../../auth/widget/auth_primary_button.dart';
import 'car_info_security_option.dart';

class CarSecurityControlBottomSheet {
  static void show({
    required BuildContext context,
    required bool isSecurityOn,
    required List<bool> states,
    required VoidCallback onSecurityCommand,
    required VoidCallback onHistoryPressed,
    required Function(List<bool>) onNewSecurity,
  }) {
    final size = MediaQuery.of(context).size;
    RxList<bool> newStates = RxList(states);
    RxBool tempIsSecurityOn = RxBool(isSecurityOn);

    void setNewState(index, value) {
      newStates[index] = value;
      newStates.refresh();
      tempIsSecurityOn.value = !newStates[6];
      tempIsSecurityOn.refresh();
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          height: size.height * .71,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .05,
              vertical: size.height * .005,
            ),
            child: Obx(
              () => Column(
                children: [
                  SizedBox(
                    height: size.height * .015,
                  ),
                  Center(
                    child: InkWell(
                      onTap: Get.back,
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFFE9B4B8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .025,
                  ),
                  Center(
                    child: SizedBox(
                      width: size.width * .4,
                      child: CarInfoSecurityOption(
                        isLargeSize: false,
                        title: 'دزدگیر',
                        isLoading: false,
                        isActive: tempIsSecurityOn.value,
                        onPressed: () {
                          tempIsSecurityOn.value = !tempIsSecurityOn.value;
                          tempIsSecurityOn.refresh();
                          newStates[6] = !tempIsSecurityOn.value;
                          newStates.refresh();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'قطع',
                              style: TextStyle(
                                fontSize: size.width * .0285,
                                fontFamily: 'YekanBakh-Regular',
                                color: const Color(0xFF828282),
                              ),
                            ),
                            CustomBorderSwitch(
                              value: tempIsSecurityOn.value,
                              onPressed: () {
                                tempIsSecurityOn.value =
                                    !tempIsSecurityOn.value;
                                tempIsSecurityOn.refresh();
                                newStates[6] = !tempIsSecurityOn.value;
                                newStates.refresh();
                              },
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
                  ),
                  SizedBox(
                    height: size.height * .015,
                  ),
                  _optionRow(context, 'سنسور ضربه', null, newStates[0],
                      (value) => setNewState(0, value)),
                  _optionRow(context, 'روشن شدن فلاشر', 'TODO', newStates[1],
                      (value) => setNewState(1, value)),
                  _optionRow(context, 'حالت هشدار', 'TODO', newStates[2],
                      (value) => setNewState(2, value)),
                  _optionRow(context, 'سنسور چشمی', null, newStates[3],
                      (value) => setNewState(3, value)),
                  _optionRow(context, 'قفل کودک', 'TODO', newStates[4],
                      (value) => setNewState(4, value)),
                  _optionRow(context, 'کلید های ترکیبی', 'TODO', newStates[5],
                      (value) => setNewState(5, value)),
                  _optionRow(context, 'حالت کارواش', 'TODO', newStates[6],
                      (value) => setNewState(6, value)),
                  _optionRow(context, 'قفل خودکار', 'TODO', newStates[7],
                      (value) => setNewState(7, value)),
                  _screenRow(context, 'سوابق', onHistoryPressed),
                  const Expanded(child: SizedBox()),
                  AuthPrimaryButton(
                    text: 'ثبت',
                    onPressed: () {
                      onNewSecurity(newStates);
                      Get.back();
                    },
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _screenRow(
    BuildContext context,
    String title,
    VoidCallback onCLick,
  ) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onCLick,
        child: SizedBox(
          height: size.height * .04,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.chevron_left_rounded,
                color: Color(0xFF189A93),
              ),
              SizedBox(
                width: size.width * .02,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: size.width * .03,
                  fontFamily: 'YekanBakh-Regular',
                  color: const Color(0xFF565656),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _optionRow(BuildContext context, String title, String? info,
      bool value, Function(bool) valueChanged) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .05,
      child: Row(
        children: [
          CupertinoSwitch(
            value: value,
            onChanged: valueChanged,
            activeColor: const Color(0xFF189A93),
          ),
          const Expanded(child: SizedBox()),
          if (info != null)
            Row(
              children: [
                InkWell(
                  onTap: () {
                    DialogBox.showInfoDialog(context: context, info: info);
                  },
                  child: const CustomSvgWidget('assets/car/info.svg'),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
              ],
            ),
          Text(
            title,
            style: TextStyle(
              fontSize: size.width * .03,
              fontFamily: 'YekanBakh-Regular',
              color: const Color(0xFF565656),
            ),
          ),
        ],
      ),
    );
  }
}
