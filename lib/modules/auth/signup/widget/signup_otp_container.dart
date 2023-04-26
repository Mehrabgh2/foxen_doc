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
import 'signup_container.dart';

class SignupGetOTPContainer extends StatelessWidget {
  final AuthenticationController authenticationController;

  const SignupGetOTPContainer({
    required this.authenticationController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => SignupContainer(
        authenticationController: authenticationController,
        step: 2,
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (authenticationController.isSignupOTPError.value ||
                  authenticationController.isSignupOTPServerError.value)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            authenticationController.signupOTPErrorString.value,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: size.width * .03,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '.',
                    style: TextStyle(
                      color: AppTheme.textFieldTextColor,
                      fontSize: size.width * .0325,
                      fontFamily: "YekanBakh-Regular",
                    ),
                  ),
                  HyperLinkText(
                    textSize: size.width * .03,
                    text: 'کد ارسال شده به ',
                    secondText: '  را وارد کنید',
                    hyperText: AppUtil.replacePersianNumber(
                        authenticationController
                            .signupPhoneTextController.text),
                    hyperColor: const Color(0xFF189A93),
                    onPressed: () {},
                  ),
                ],
              ),
              _verticalSpacer(size / 1.5),
              SizedBox(
                width: size.width * .5,
                child: Column(
                  children: [
                    CustomTextField(
                      controller:
                          authenticationController.signupOTPTextController,
                      maxLength: 5,
                      type: TextInputType.number,
                      textAlign: TextAlign.center,
                      focusNode: authenticationController.signupOtpFocus,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        authenticationController.canResendOTP.value
                            ? HyperLinkText(
                                textSize: size.width * .03,
                                hyperText: 'ارسال مجدد',
                                hyperColor: Colors.blue,
                                onPressed: authenticationController
                                        .isResendingOTP.value
                                    ? null
                                    : authenticationController.resendOTP,
                              )
                            : authenticationController.otpCountdown,
                        Text(
                          'کدی برایتان ارسال نشد؟',
                          style: TextStyle(
                            fontSize: size.width * .0275,
                            fontFamily: 'YekanBakh-Regular',
                            color: AppTheme.hintColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              _verticalSpacer(size),
              authenticationController.isSubmitOTPLoading.value
                  ? const SizedBox(
                      width: AuthAccentButton.height,
                      height: AuthAccentButton.height,
                      child: SpinKitFadingCircle(
                        color: Colors.blue,
                        size: AuthAccentButton.height,
                      ),
                    )
                  : AuthAccentButton(
                      text: 'شروع',
                      onPressed: authenticationController.submitPhone,
                      width: .5,
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
