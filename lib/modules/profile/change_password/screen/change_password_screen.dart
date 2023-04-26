import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foxenapp/modules/profile/change_password/controller/change_password_controller.dart';
import 'package:foxenapp/modules/profile/change_password/widget/password_row.dart';
import 'package:foxenapp/util/app_theme.dart';
import 'package:foxenapp/widget/custom_svg_widget.dart';
import 'package:get/get.dart';
import '../../../../widget/home_appbar.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<ChangePasswordController>(
        init: Get.put(ChangePasswordController()),
        builder: (controller) {
          return Column(
            children: [
              HomeAppBar(
                title: 'تغییر رمز عبور',
                onBack: Get.back,
              ),
              Obx(
                () => Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * .035,
                        vertical: size.height * .02,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * .01,
                              horizontal: size.width * .035,
                            ),
                            width: size.width,
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
                              children: [
                                SizedBox(height: size.height * .005),
                                if (controller.isOldPasswordError.value ||
                                    controller.isNewPasswordError.value ||
                                    controller.isRepeatNewPasswordError.value ||
                                    controller.isServerError.value)
                                  Column(
                                    children: [
                                      SizedBox(height: size.height * .005),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              controller.errorString.value,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: size.width * .03,
                                                fontFamily: 'YekanBakh-Regular',
                                                color: AppTheme.errorTextColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * .02,
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
                                      SizedBox(height: size.height * .0125),
                                      Container(
                                        color: const Color(0xFFE6E6E6),
                                        height: 1,
                                      ),
                                      SizedBox(height: size.height * .01),
                                    ],
                                  ),
                                SizedBox(height: size.height * .0025),
                                PasswordRow(
                                  title: 'رمز عبور فعلی',
                                  textController:
                                      controller.oldPasswordController,
                                  isError: controller.isOldPasswordError.value,
                                ),
                                PasswordRow(
                                  title: 'رمز عبور جدید',
                                  textController:
                                      controller.newPasswordController,
                                  isError: controller.isNewPasswordError.value,
                                ),
                                PasswordRow(
                                  title: 'تکرار رمز عبور جدید',
                                  textController:
                                      controller.repeatNewPasswordController,
                                  isError:
                                      controller.isRepeatNewPasswordError.value,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Material(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xFFF9EBEC),
                                  child: InkWell(
                                    onTap: Get.back,
                                    borderRadius: BorderRadius.circular(12),
                                    child: SizedBox(
                                      height: size.height * .055,
                                      child: Center(
                                        child: Text(
                                          'انصراف',
                                          style: TextStyle(
                                            fontSize: size.width * .035,
                                            fontFamily: 'YekanBakh-Bold',
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFFF85763),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .055,
                              ),
                              Expanded(
                                child: controller.isSubmitting.value
                                    ? const SpinKitFadingCircle(
                                        color: Colors.blue,
                                      )
                                    : Material(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color(0xFF84C31E),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          onTap: controller.submit,
                                          child: SizedBox(
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
