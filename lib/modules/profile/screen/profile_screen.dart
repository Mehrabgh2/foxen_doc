import 'package:flutter/material.dart';
import 'package:foxenapp/controller/foxen_user_controller.dart';
import 'package:foxenapp/modules/bottom_navigation/widget/custom_bottom_navigation.dart';
import 'package:foxenapp/modules/profile/change_password/screen/change_password_screen.dart';
import 'package:foxenapp/modules/profile/fingerprint/screen/fingerprint_screen.dart';
import 'package:foxenapp/modules/profile/widget/exit_button.dart';
import 'package:foxenapp/modules/profile/widget/user_info_option.dart';
import 'package:foxenapp/widget/primary_option.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FoxenUserController foxenUserController =
        Get.find<FoxenUserController>();
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * .02,
        ),
        UserInfoOption(
          title: foxenUserController.user.value != null &&
                  foxenUserController.user.value!.user != null &&
                  !(foxenUserController.user.value!.user!.firstname == null &&
                      foxenUserController.user.value!.user!.lastname == null)
              ? '${foxenUserController.user.value!.user!.firstname ?? ''} ${foxenUserController.user.value!.user!.lastname ?? ''}'
              // TODO text
              : 'نامشخص',
          onPressed: () {},
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width * .05,
            vertical: size.height * .01,
          ),
          color: const Color(0xFFE6E6E6),
          height: 1,
        ),
        PrimaryOption(
          title: 'تغییر رمز عبور',
          icon: 'assets/support/temp.svg',
          onPressed: () => Get.to(
            () => const ChangePasswordScreen(),
            transition: Transition.rightToLeft,
          ),
        ),
        PrimaryOption(
          title: 'حسگر اثر انگشت',
          icon: 'assets/support/temp.svg',
          onPressed: () => Get.to(
            () => const FingerprintScreen(),
            transition: Transition.rightToLeft,
          ),
        ),
        PrimaryOption(
          title: 'بروزرسانی نسخه',
          icon: 'assets/support/temp.svg',
          onPressed: () {},
        ),
        const Expanded(child: SizedBox()),
        const ExitButton(),
        SizedBox(
          height: CustomBottomNavigation.height + size.height * .055,
        ),
      ],
    );
  }
}
