import 'package:flutter/material.dart';
import 'package:foxenapp/modules/bottom_navigation/widget/custom_bottom_navigation.dart';
import 'package:foxenapp/modules/car_setting/car_setting_sms_command/screen/car_setting_sms_command_screen.dart';
import 'package:foxenapp/modules/support/support_tutorial_videos/screen/support_tutorial_videos_screen.dart';
import 'package:foxenapp/widget/primary_option.dart';
import 'package:foxenapp/widget/custom_svg_widget.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * .02,
        ),
        PrimaryOption(
          title: 'ویدیوهای آموزشی',
          icon: 'assets/support/temp.svg',
          onPressed: () => Get.to(
            () => const SupportTutorialVideosScreen(),
            transition: Transition.rightToLeft,
          ),
        ),
        PrimaryOption(
          title: 'سوالات متداول',
          icon: 'assets/support/temp.svg',
          onPressed: () {},
        ),
        PrimaryOption(
          title: 'راه اندازی سیمکارت',
          icon: 'assets/support/temp.svg',
          onPressed: () {},
        ),
        const Expanded(child: SizedBox()),
        InkWell(
          onTap: () {
            launchUrl(Uri.parse('tel:02158431'));
          },
          overlayColor: MaterialStateColor.resolveWith(
            (states) => Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * .08,
                height: size.width * .08,
                child: Transform.rotate(
                  angle: -1.3,
                  child:
                      const CustomSvgWidget('assets/authentication/phone.svg'),
                ),
              ),
              SizedBox(
                width: size.width * .4,
                child: const FittedBox(
                  child: Text(
                    '۰۲۱۵۸۴۳۱',
                    style: TextStyle(
                      color: Color(0xFF84C31E),
                      fontFamily: 'YekanBakh-Bold',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: CustomBottomNavigation.height + size.height * .04,
        ),
      ],
    );
  }
}
