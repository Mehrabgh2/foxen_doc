import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/authentication_controller.dart';
import '../../screen/auth_screen.dart';
import '../widget/signup_get_information_container.dart';
import '../widget/signup_get_license_container.dart';
import '../widget/signup_otp_container.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      init: AuthenticationController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () {
            if (controller.signupPageController.page!.toInt() == 0 ||
                controller.signupPageController.page!.toInt() == 2) {
              controller.resetLoginScreen();
              return Future.value(true);
            } else {
              controller.previousSignupPage();
              return Future.value(false);
            }
          },
          child: AuthScreen(
            authType: AuthType.signup,
            child: PageView(
              controller: controller.signupPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SignupGetLicenseContainer(
                  authenticationController: controller,
                ),
                SignupGetInformationContainer(
                  authenticationController: controller,
                ),
                SignupGetOTPContainer(
                  authenticationController: controller,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
