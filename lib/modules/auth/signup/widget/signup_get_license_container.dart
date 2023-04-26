import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../controller/authentication_controller.dart';
import 'signup_container.dart';
import '../../widget/auth_accent_button.dart';
import '../../../../util/app_theme.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/custom_text_field.dart';
import 'package:get/get.dart';

class SignupGetLicenseContainer extends StatelessWidget {
  final AuthenticationController authenticationController;

  const SignupGetLicenseContainer({
    required this.authenticationController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => SignupContainer(
        authenticationController: authenticationController,
        step: 0,
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (authenticationController
                      .isSignupLicenseVehicleNameError.value ||
                  authenticationController.isSignupLicenseSerialError.value ||
                  authenticationController.isSignupLicenseWarrantyError.value ||
                  authenticationController.isSignupLicenseServerError.value)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            authenticationController
                                .signupLicenseErrorString.value,
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
                          .signupVehicleNameTextController,
                      isError: authenticationController
                          .isSignupLicenseVehicleNameError.value,
                      autoFocus: true,
                    ),
                  ),
                  Text(
                    'نام خودرو',
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
                          authenticationController.signupSerialTextController,
                      isError: authenticationController
                          .isSignupLicenseSerialError.value,
                    ),
                  ),
                  Text(
                    'شماره سریال ردیاب',
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
                      controller:
                          authenticationController.signupWarrantyTextController,
                      isError: authenticationController
                          .isSignupLicenseWarrantyError.value,
                      subChild: Text(
                        'شماره سریال و کد گارانتی بر روی دستگاه ردیاب شما ثبت شده است',
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
                        'کد گارانتی ردیاب',
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
              authenticationController.isSignupLicenseLoading.value
                  ? const SizedBox(
                      width: AuthAccentButton.height,
                      height: AuthAccentButton.height,
                      child: SpinKitFadingCircle(
                        color: Colors.blue,
                        size: AuthAccentButton.height,
                      ),
                    )
                  : AuthAccentButton(
                      text: 'بعدی',
                      onPressed: authenticationController.signupCheckLicense,
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
