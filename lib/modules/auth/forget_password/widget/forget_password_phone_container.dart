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

class ForgetPasswordPhoneContainer extends StatelessWidget {
  final AuthenticationController authenticationController;

  const ForgetPasswordPhoneContainer({
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
              if (authenticationController.isForgetPasswordPhoneError.value ||
                  authenticationController
                      .isForgetPasswordPhoneServerError.value)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            authenticationController
                                .forgetPasswordPhoneErrorString.value,
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
                    '.خود را برای ارسال کد تایید وارد کنید',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: size.width * .0275,
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF565656),
                    ),
                  ),
                  Text(
                    ' شماره تلفن همراه',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: size.width * .0325,
                      fontFamily: 'YekanBakh-Bold',
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF565656),
                    ),
                  ),
                  Text(
                    'لطفا ',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: size.width * .0275,
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF565656),
                    ),
                  ),
                ],
              ),
              _verticalSpacer(size),
              SizedBox(
                width: size.width * .7,
                child: CustomTextField(
                  controller: authenticationController
                      .forgetPasswordPhoneTextController,
                  isError:
                      authenticationController.isForgetPasswordPhoneError.value,
                  type: TextInputType.number,
                  autoFocus: true,
                ),
              ),
              _verticalSpacer(size),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AuthCancelButton(text: 'انصراف', onPressed: Get.back),
                  authenticationController.isForgetPasswordPhoneLoading.value
                      ? SizedBox(
                          width: size.width * .325,
                          height: AuthAccentButton.height,
                          child: const SpinKitFadingCircle(
                            color: Colors.blue,
                            size: AuthAccentButton.height,
                          ),
                        )
                      : AuthAccentButton(
                          text: 'ارسال کد تایید',
                          onPressed: () {
                            authenticationController.sendForgetOTP(false);
                          },
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
