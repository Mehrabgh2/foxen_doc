import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../controller/authentication_controller.dart';
import 'forget_password_container.dart';
import '../../widget/auth_accent_button.dart';
import '../../widget/auth_cancel_button.dart';
import '../../../../util/app_theme.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/custom_text_field.dart';
import 'package:get/get.dart';

class ForgetPasswordNewPasswordContainer extends StatelessWidget {
  final AuthenticationController authenticationController;

  const ForgetPasswordNewPasswordContainer({
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
              if (authenticationController
                      .isForgetPasswordNewPasswordError.value ||
                  authenticationController
                      .isForgetPasswordRepeatPasswordError.value ||
                  authenticationController
                      .isForgetPasswordNewPasswordServerError.value)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            authenticationController
                                .forgetPasswordNewPasswordErrorString.value,
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
              Text(
                'رمز عبور جدید را وارد کنید',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: size.width * .03,
                  fontFamily: 'YekanBakh-Regular',
                  color: AppTheme.hintColor,
                ),
              ),
              _verticalSpacer(size),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * .5,
                    child: CustomTextField(
                      isPassword: true,
                      controller: authenticationController
                          .forgetPasswordPasswordTextController,
                      isError: authenticationController
                          .isForgetPasswordNewPasswordError.value,
                      focusNode: authenticationController
                          .forgetPasswordNewPasswordFocus,
                    ),
                  ),
                  Text(
                    'رمز عبور جدید',
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
                      isPassword: true,
                      controller: authenticationController
                          .forgetPasswordRepeatPasswordTextController,
                      isError: authenticationController
                          .isForgetPasswordRepeatPasswordError.value,
                    ),
                  ),
                  Text(
                    'تکرار  رمز عبور جدید',
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
                  AuthCancelButton(
                    text: 'انصراف',
                    onPressed: Get.back,
                    width: .375,
                  ),
                  authenticationController
                          .isForgetPasswordNewPasswordLoading.value
                      ? SizedBox(
                          width: size.width * .4,
                          height: AuthAccentButton.height,
                          child: const SpinKitFadingCircle(
                            color: Colors.blue,
                            size: AuthAccentButton.height,
                          ),
                        )
                      : AuthAccentButton(
                          text: 'تأیید',
                          onPressed:
                              authenticationController.submitForgetNewPassword,
                          width: .375,
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
