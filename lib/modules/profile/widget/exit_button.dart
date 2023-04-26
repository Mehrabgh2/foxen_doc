import 'package:flutter/material.dart';
import 'package:foxenapp/modules/auth/controller/authentication_controller.dart';
import 'package:foxenapp/widget/dialog_box.dart';
import 'package:get/instance_manager.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .2,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        shadowColor: Colors.grey.withAlpha(30),
        elevation: 8,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            DialogBox.showLogoutConfirmationDialog(
              context: context,
              confirmPressed: () {
                AuthenticationController authController =
                    Get.put<AuthenticationController>(
                        AuthenticationController());
                authController.logout();
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1.5,
                color: const Color(0xFFEEEEEE),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: size.height * .0225,
              horizontal: size.width * .025,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: size.width * .01,
                ),
                const Icon(
                  Icons.logout,
                  color: Color(0xFF32769E),
                  size: 22,
                ),
                const Expanded(child: SizedBox()),
                Text(
                  'خروج از حساب کاربری',
                  style: TextStyle(
                    fontFamily: 'YekanBakh-Bold',
                    color: const Color(0xFF32769E),
                    fontSize: size.width * .035,
                  ),
                ),
                SizedBox(
                  width: size.width * .025,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
