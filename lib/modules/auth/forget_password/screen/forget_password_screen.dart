import 'package:flutter/material.dart';
import '../../controller/authentication_controller.dart';
import '../widget/forget_password_new_password_container.dart';
import '../widget/forget_password_otp_container.dart';
import '../widget/forget_password_phone_container.dart';
import '../../screen/auth_screen.dart';
import '../../widget/auth_appbar.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      init: AuthenticationController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () {
            if (controller.forgetPasswordPageController.page!.toInt() == 0) {
              return Future.value(true);
            } else {
              controller.previousForgetPasswordPage();
              return Future.value(false);
            }
          },
          child: AuthScreen(
            authType: AuthType.forget,
            child: Column(
              children: [
                AuthAppBar(
                  onBack: controller.previousForgetPasswordPage,
                  title: 'فراموشی رمز عبور',
                ),
                Expanded(
                  child: PageView(
                    controller: controller.forgetPasswordPageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ForgetPasswordPhoneContainer(
                        authenticationController: controller,
                      ),
                      ForgetPasswordOTPContainer(
                        authenticationController: controller,
                      ),
                      ForgetPasswordNewPasswordContainer(
                        authenticationController: controller,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
