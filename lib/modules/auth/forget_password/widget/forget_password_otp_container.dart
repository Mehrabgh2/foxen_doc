import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../util/app_theme.dart';
import '../../../../util/app_util.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/custom_text_field.dart';
import '../../../../widget/hyper_link_text.dart';
import '../../controller/authentication_controller.dart';
import '../../widget/auth_accent_button.dart';
import '../../widget/auth_cancel_button.dart';
import 'forget_password_container.dart';

class ForgetPasswordOTPContainer extends StatelessWidget {
  final AuthenticationController authenticationController;

  const ForgetPasswordOTPContainer({
    required this.authenticationController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => ForgetPasswordContainer(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (authenticationController.isForgetPasswordOTPError.value ||
                  authenticationController.isForgetPasswordOTPServerError.value)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            authenticationController
                                .forgetPasswordOTPErrorString.value,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: size.width * .03,
                              fontFamily: 'YekanBakh-Regular',
                              color: AppTheme.errorTextColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * .01,
                        ),
                        SizedBox(
                          height: size.width * .05,
                          width: size.width * .05,
                          child: const CustomSvgWidget(
                            'assets/authentication/warning.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    _verticalSpacer(size),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '.',
                    style: TextStyle(
                      color: AppTheme.textFieldTextColor,
                      fontSize: size.width * .0315,
                      fontFamily: "YekanBakh-Regular",
                    ),
                  ),
                  HyperLinkText(
                    textSize: size.width * .0315,
                    text: ' پیامک شده به شماره ',
                    secondText: '  را وارد کنید',
                    hyperText: AppUtil.replacePersianNumber(
                        authenticationController
                            .forgetPasswordPhoneTextController.text),
                    hyperColor: const Color(0xFF189A93),
                    onPressed: () {},
                  ),
                  Text(
                    ' کد تایید',
                    style: TextStyle(
                      color: AppTheme.textFieldTextColor,
                      fontSize: size.width * .0325,
                      fontWeight: FontWeight.bold,
                      fontFamily: "YekanBakh-Bold",
                    ),
                  ),
                ],
              ),
              _verticalSpacer(size),
              SizedBox(
                width: size.width * .5,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: authenticationController
                          .forgetPasswordOTPTextController,
                      maxLength: 5,
                      type: TextInputType.number,
                      textAlign: TextAlign.center,
                      focusNode:
                          authenticationController.forgetPasswordOtpFocus,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        authenticationController.canResendForgetOTP.value
                            ? HyperLinkText(
                                textSize: size.width * .03,
                                hyperText: 'ارسال مجدد',
                                hyperColor: Colors.blue,
                                onPressed: authenticationController
                                        .isForgetPasswordPhoneLoading.value
                                    ? null
                                    : () {
                                        authenticationController
                                            .sendForgetOTP(true);
                                      },
                              )
                            : authenticationController
                                .forgetPasswordOtpCountdown,
                        InkWell(
                          onTap: authenticationController.editForgetPhone,
                          child: Text(
                            'ویرایش شماره تلفن',
                            style: TextStyle(
                              color: AppTheme.textFieldTextColor,
                              fontSize: size.width * .0275,
                              fontFamily: "YekanBakh-Regular",
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _verticalSpacer(size),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AuthCancelButton(text: 'انصراف', onPressed: Get.back),
                  authenticationController.isForgetPasswordOTPLoading.value
                      ? SizedBox(
                          width: size.width * .325,
                          height: AuthAccentButton.height,
                          child: const SpinKitFadingCircle(
                            color: Colors.blue,
                            size: AuthAccentButton.height,
                          ),
                        )
                      : AuthAccentButton(
                          text: 'تأیید',
                          onPressed: authenticationController.submitForgetOTP,
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _verticalSpacer(Size size) {
    return SizedBox(
      height: size.height * .02,
    );
  }
}
