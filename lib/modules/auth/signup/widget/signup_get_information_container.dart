import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../controller/authentication_controller.dart';
import 'signup_container.dart';
import '../../widget/auth_accent_button.dart';
import '../../../../util/app_theme.dart';
import '../../../../util/app_util.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/custom_text_field.dart';
import 'package:get/get.dart';

class SignupGetInformationContainer extends StatelessWidget {
  final AuthenticationController authenticationController;

  const SignupGetInformationContainer({
    required this.authenticationController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => SignupContainer(
        authenticationController: authenticationController,
        step: 1,
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (authenticationController
                      .isSignupInformationFirstNameError.value ||
                  authenticationController
                      .isSignupInformationLastNameError.value ||
                  authenticationController
                      .isSignupInformationUsernameError.value ||
                  authenticationController
                      .isSignupInformationPasswordError.value ||
                  authenticationController
                      .isSignupInformationPhoneError.value ||
                  authenticationController.isSignupInformationServerError.value)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            authenticationController
                                .signupInformationErrorString.value,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * .5,
                    child: CustomTextField(
                      controller: authenticationController
                          .signupFirstNameTextController,
                      isError: authenticationController
                          .isSignupInformationFirstNameError.value,
                      focusNode: authenticationController.signupNameFocus,
                    ),
                  ),
                  Text(
                    'نام',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: size.width * .03,
                      fontFamily: 'YekanBakh-Regular',
                      color: AppTheme.loginTextColor,
                    ),
                  ),
                ],
              ),
              _verticalSpacer(size),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * .5,
                    child: CustomTextField(
                      controller:
                          authenticationController.signupLastNameTextController,
                      isError: authenticationController
                          .isSignupInformationLastNameError.value,
                    ),
                  ),
                  Text(
                    'نام خانوادگی',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: size.width * .03,
                      fontFamily: 'YekanBakh-Regular',
                      color: AppTheme.loginTextColor,
                    ),
                  ),
                ],
              ),
              _verticalSpacer(size),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * .5,
                    child: CustomTextField(
                      controller:
                          authenticationController.signupUsernameTextController,
                      isError: authenticationController
                          .isSignupInformationUsernameError.value,
                    ),
                  ),
                  Text(
                    'نام کاربری',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: size.width * .03,
                      fontFamily: 'YekanBakh-Regular',
                      color: AppTheme.loginTextColor,
                    ),
                  ),
                ],
              ),
              _verticalSpacer(size),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * .5,
                    child: CustomTextField(
                      isPassword: true,
                      controller:
                          authenticationController.signupPasswordTextController,
                      isError: authenticationController
                          .isSignupInformationPasswordError.value,
                      subChild: Text(
                        AppUtil.replacePersianNumber(
                            'رمز عبور شما باید حداقل شامل 6 کاراکتر و متشکل از حروف و اعداد انگلیسی باشد'),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: size.width * .03,
                          fontFamily: 'YekanBakh-Regular',
                          color: AppTheme.hintColor,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: CustomTextField.height / 4,
                      ),
                      Text(
                        'رمز عبور',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: size.width * .03,
                          fontFamily: 'YekanBakh-Regular',
                          color: AppTheme.loginTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _verticalSpacer(size),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * .5,
                    child: CustomTextField(
                      type: TextInputType.number,
                      controller:
                          authenticationController.signupPhoneTextController,
                      isError: authenticationController
                          .isSignupInformationPhoneError.value,
                    ),
                  ),
                  Text(
                    'شماره تلفن',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: size.width * .03,
                      fontFamily: 'YekanBakh-Regular',
                      color: AppTheme.loginTextColor,
                    ),
                  ),
                ],
              ),
              _verticalSpacer(size),
              authenticationController.isSignupOTPLoading.value
                  ? SizedBox(
                      width: size.width * .325,
                      height: AuthAccentButton.height,
                      child: const SpinKitFadingCircle(
                        color: Colors.blue,
                        size: AuthAccentButton.height,
                      ),
                    )
                  : AuthAccentButton(
                      text: 'ارسال کد تأیید',
                      onPressed: authenticationController.signup,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _verticalSpacer(Size size) {
    return SizedBox(
      height: size.height * .01,
    );
  }
}
