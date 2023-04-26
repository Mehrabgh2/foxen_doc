import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foxenapp/modules/profile/fingerprint/controller/fingerprint_controller.dart';
import 'package:foxenapp/modules/support/support_tutorial_videos/controller/support_tutorial_videos_controller.dart';
import 'package:foxenapp/widget/dialog_box.dart';
import 'package:get/get.dart';
import '../../../../widget/home_appbar.dart';

class FingerprintScreen extends StatelessWidget {
  const FingerprintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<FingerprintController>(
        init: Get.find<FingerprintController>(),
        builder: (controller) {
          return Obx(
            () => Column(
              children: [
                HomeAppBar(
                  title: 'حسگر اثرانگشت',
                  onBack: Get.back,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: size.height * .02,
                        horizontal: size.width * .035,
                      ),
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * .05,
                                ),
                                Expanded(
                                  child: Text(
                                    'غیرفعال',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: size.width * .03,
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF4F4F4F),
                                    ),
                                  ),
                                ),
                                CupertinoSwitch(
                                  activeColor: const Color(0xFF189A93),
                                  value: controller
                                      .constantsPrefrencesController
                                      .constant
                                      .value
                                      .biometricAuthentication,
                                  onChanged: (value) {
                                    if (value) {
                                      DialogBox.showTurnOnBiometricDialog();
                                    } else {
                                      controller.turnOff();
                                    }
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    'فعال',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: size.width * .03,
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF4F4F4F),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .05,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
