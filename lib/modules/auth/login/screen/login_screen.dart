import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../controller/authentication_controller.dart';
import '../widget/login_container.dart';
import '../../screen/auth_screen.dart';
import '../../widget/auth_accent_button.dart';
import '../../widget/auth_primary_button.dart';
import '../../widget/auth_support_widget.dart';
import '../../../../util/app_theme.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/custom_text_field.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    final size = MediaQuery.of(context).size;
    return GetBuilder<AuthenticationController>(
      init: AuthenticationController(),
      builder: (controller) {
        return AuthScreen(
          authType: AuthType.login,
          child: Column(
            children: [
              SizedBox(
                height: size.height * .085,
              ),
              SizedBox(
                width: size.width * .3,
                child: Image.asset(
                  'assets/logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              LoginContainer(
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (controller.isLoginUsernameError.value ||
                          controller.isLoginPasswordError.value ||
                          controller.isLoginServerError.value)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.loginErrorString.value,
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * .03,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller:
                                        controller.loginUsernameTextController,
                                    maxLine: 1,
                                    type: TextInputType.name,
                                    maxLength: 15,
                                    isError:
                                        controller.isLoginUsernameError.value,
                                    autoFocus: false,
                                  ),
                                ),
                                _horizontalSpacer(size),
                                SizedBox(
                                  width: size.width * .125,
                                  child: Text(
                                    'نام کاربری',
                                    maxLines: 1,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: size.width * .03,
                                      fontFamily: 'YekanBakh-Regular',
                                      color: AppTheme.loginTextColor,
                                    ),
                                  ),
                                ),
                                _horizontalSpacer(size),
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  width: CustomTextField.height,
                                  height: CustomTextField.height,
                                  child: const CustomSvgWidget(
                                    'assets/authentication/person.svg',
                                  ),
                                ),
                              ],
                            ),
                            _verticalSpacer(size),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller:
                                        controller.loginPasswordTextController,
                                    isPassword: true,
                                    maxLine: 1,
                                    type: TextInputType.name,
                                    maxLength: 15,
                                    isError:
                                        controller.isLoginPasswordError.value,
                                    focusNode: controller.loginPasswordFocus,
                                    subChild: SizedBox(
                                      height: size.height * .035,
                                      child: FittedBox(
                                        child: InkWell(
                                          onTap: controller.goToForgetPassword,
                                          child: Text(
                                            'رمز عبورتان را فراموش کرده اید؟',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: size.width * .0285,
                                              fontFamily: 'YekanBakh-Regular',
                                              color: AppTheme.errorTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                _horizontalSpacer(size),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: CustomTextField.height / 4,
                                    ),
                                    SizedBox(
                                      width: size.width * .125,
                                      child: Text(
                                        'رمز عبور',
                                        maxLines: 1,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: size.width * .03,
                                          fontFamily: 'YekanBakh-Regular',
                                          color: AppTheme.loginTextColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                _horizontalSpacer(size),
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  width: CustomTextField.height,
                                  height: CustomTextField.height,
                                  child: const CustomSvgWidget(
                                    'assets/authentication/lock.svg',
                                  ),
                                ),
                              ],
                            ),
                            _verticalSpacer(size),
                          ],
                        ),
                      ),
                      Center(
                        child: controller.isLoginLoading.value
                            ? const SizedBox(
                                width: AuthPrimaryButton.height,
                                height: AuthPrimaryButton.height,
                                child: SpinKitFadingCircle(
                                  color: Colors.blue,
                                  size: AuthPrimaryButton.height,
                                ),
                              )
                            : AuthPrimaryButton(
                                text: 'ورود',
                                onPressed: controller.login,
                              ),
                      ),
                      _verticalSpacer(size / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: AuthSupportWidget(
                            callSupport: controller.callSupport,
                          )),
                          AuthAccentButton(
                            text: 'ثبت نام',
                            onPressed: controller.goToSignup,
                          ),
                          Expanded(
                            child: Opacity(
                              opacity: 0,
                              child: AuthSupportWidget(
                                callSupport: controller.callSupport,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _verticalSpacer(Size size) {
    return SizedBox(
      height: size.height * .01,
    );
  }

  Widget _horizontalSpacer(Size size) {
    return SizedBox(
      width: size.width * .02,
    );
  }
}
