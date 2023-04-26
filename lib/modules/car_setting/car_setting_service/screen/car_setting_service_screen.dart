import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';

import '../../../../model/foxen_device.dart';
import '../../../../util/app_theme.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/custom_text_field.dart';
import '../../../../widget/home_appbar.dart';
import '../controller/car_setting_service_controller.dart';

class CarSettingServiceScreen extends StatelessWidget {
  const CarSettingServiceScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<CarSettingServiceController>(
        init: CarSettingServiceController(device: device),
        builder: (controller) {
          return Column(
            children: [
              HomeAppBar(
                title: 'تنظیمات',
                title2: DeviceFieldExtractor.getCarName(device),
                onBack: Get.back,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: size.height * .02,
                        horizontal: size.width * .035,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * .01,
                        horizontal: size.width * .035,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(100),
                            spreadRadius: -2,
                            blurRadius: 15,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoSwitch(
                                value: controller.hidden.value,
                                onChanged: controller.updateIsHidden,
                                activeColor: const Color(0xFF189A93),
                              ),
                              Text(
                                'یادآوری سرویس های ماشین',
                                style: TextStyle(
                                  fontFamily: 'YekanBakh-Bold',
                                  color: const Color(0xFF8D8D8D),
                                  fontSize: size.width * .0285,
                                ),
                              ),
                            ],
                          ),
                          _verticalSpacer(size * 2),
                          SizedBox(
                            height: CustomTextField.height * 1.25,
                            width: size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color:
                                                AppTheme.textFieldBackground,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        bottom: 0,
                                        right: 0,
                                        left: size.width * .03,
                                        child: DropDownMultiSelect(
                                          onChanged: (List<String> x) {
                                            controller.sendTypes = x;
                                          },
                                          options: const [
                                            'sms',
                                            'email',
                                            'webNotification'
                                          ],
                                          selectedValues:
                                              controller.sendTypes,
                                          whenEmpty: '',
                                          isDense: true,
                                          childBuilder: (selectedValues) {
                                            return Text(
                                              selectedValues.join(' , '),
                                              style: TextStyle(
                                                fontFamily: 'YekanBakh-Bold',
                                                color:
                                                    const Color(0xFF8D8D8D),
                                                fontSize: size.width * .03,
                                              ),
                                            );
                                          },
                                          decoration: InputDecoration(
                                            counterText: '',
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8))),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(8))),
                                            alignLabelWithHint: true,
                                            labelStyle: TextStyle(
                                              fontFamily: 'YekanBakh-Regular',
                                              fontSize: size.width * .0275,
                                              color:
                                                  AppTheme.textFieldTextColor,
                                            ),
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            hintStyle: const TextStyle(
                                              color: Color(0xFF979797),
                                              fontSize: 12.0,
                                              fontFamily: 'YekanBakh-Regular',
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: size.width * .02,
                                              vertical: size.height * .01,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'نحوه یادآوری',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Bold',
                                      color: const Color(0xFF8D8D8D),
                                      fontSize: size.width * .0285,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _verticalSpacer(size),
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'روز قبل',
                                      style: TextStyle(
                                        fontFamily: 'YekanBakh-Bold',
                                        color: const Color(0xFF8D8D8D),
                                        fontSize: size.width * .0285,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * .02,
                                    ),
                                    SizedBox(
                                      width: size.width * .3,
                                      child: CustomTextField(
                                        controller:
                                            controller.earlyWarningController,
                                        type: TextInputType.number,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  'زمان یادآوری',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'YekanBakh-Bold',
                                    color: const Color(0xFF8D8D8D),
                                    fontSize: size.width * .0285,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _verticalSpacer(size),
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'کیلومتر باقیمانده',
                                      style: TextStyle(
                                        fontFamily: 'YekanBakh-Bold',
                                        color: const Color(0xFF8D8D8D),
                                        fontSize: size.width * .0285,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * .02,
                                    ),
                                    SizedBox(
                                      width: size.width * .3,
                                      child: CustomTextField(
                                        controller: controller
                                            .earlyWarningOdometerController,
                                        type: TextInputType.number,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(flex: 4, child: SizedBox()),
                            ],
                          ),
                          _verticalSpacer(size),
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        controller: controller
                                            .earlyWarningTimeController,
                                        onPressed:
                                            controller.pickEarlyWarningTime,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * .02,
                                    ),
                                    Text(
                                      'در ساعت',
                                      style: TextStyle(
                                        fontFamily: 'YekanBakh-Bold',
                                        color: const Color(0xFF8D8D8D),
                                        fontSize: size.width * .0285,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(flex: 4, child: SizedBox()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    controller.isSubmitLoading.value
                        ? const SpinKitFadingCircle(
                            color: Colors.blue,
                          )
                        : Material(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF84C31E),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: controller.submitServiceReminder,
                              child: SizedBox(
                                width: size.width * .35,
                                height: size.height * .05,
                                child: Center(
                                  child: Text(
                                    'ثبت تغییرات',
                                    style: TextStyle(
                                      fontSize: size.width * .035,
                                      fontFamily: 'YekanBakh-Bold',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _verticalSpacer(Size size) {
    return SizedBox(
      height: size.height * .0065,
    );
  }
}
