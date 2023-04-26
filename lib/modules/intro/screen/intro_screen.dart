import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../util/app_theme.dart';
import '../../../widget/custom_svg_widget.dart';
import '../../auth/widget/auth_accent_button.dart';
import '../controller/intro_controller.dart';
import '../widget/intro_widget.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});
  final IntroController controller = Get.put(IntroController());
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 60 + MediaQuery.of(context).viewPadding.top,
            color: Colors.white,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top,
              right: 4,
              left: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    overlayColor: MaterialStateProperty.resolveWith(
                      (states) => AppTheme.hintColor.withAlpha(50),
                    ),
                    borderRadius: BorderRadius.circular(100.0),
                    onTap: controller.previusPage,
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(20),
                      child: const CustomSvgWidget(
                        'assets/authentication/chevron_back.svg',
                        color: Color(0xFF979797),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(4),
                  child: Image.asset('assets/logo.jpg'),
                ),
              ],
            ),
          ),
          Obx(
            () => Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      controller: controller.pageController,
                      children: [
                        IntroWidget(
                          image: 'assets/intro/1.png',
                          child: SizedBox(
                            width: size.width * .725,
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'موقعیت مکانی ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Bold',
                                      fontSize: size.width * .0425,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'و ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'سرعت لحظه ای ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Bold',
                                      fontSize: size.width * .0425,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'ماشین خود را ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'بررسی کنید',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        IntroWidget(
                          image: 'assets/intro/2.png',
                          child: SizedBox(
                            width: size.width * .725,
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'بوسیله تلفن همراهتان، ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'به ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'دزدگیر ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Bold',
                                      fontSize: size.width * .0425,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'ماشین خود ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'دسترسی داشته باشید',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        IntroWidget(
                          image: 'assets/intro/3.png',
                          child: SizedBox(
                            width: size.width * .725,
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'سرویس های تعمیراتی ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Bold',
                                      fontSize: size.width * .0425,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'ماشین خود را ثبت کنید و به موقع از زمان انجام آن ها مطلع شوید',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        IntroWidget(
                          image: 'assets/intro/4.png',
                          child: SizedBox(
                            width: size.width * .725,
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        'از وضعیت وعملکرد ماشین خود در روزهای گذشته ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'گزارش گیری ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Bold',
                                      fontSize: size.width * .0425,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'کنید',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        IntroWidget(
                          image: 'assets/intro/5.png',
                          child: SizedBox(
                            width: size.width * .725,
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'و با ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'جلوگیری از روشن شدن ',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Bold',
                                      fontSize: size.width * .0425,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'ماشین خود از راه دور، امنیت آن را فراهم کنید',
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh-Regular',
                                      fontSize: size.width * .04,
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * .065,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: AuthAccentButton.height,
                          child: Material(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              onTap: controller.done,
                              child: Center(
                                child: Text(
                                  'رد کردن',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'YekanBakh-Bold',
                                    fontSize: size.width * .035,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF828282),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * .065,
                      ),
                      Expanded(
                        child: AuthAccentButton(
                          text: controller.page.value == 4 ? 'شروع' : 'بعدی',
                          onPressed: controller.page.value == 4
                              ? controller.done
                              : controller.nextPage,
                        ),
                      ),
                      SizedBox(
                        width: size.width * .065,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: controller.page.value,
                    count: 5,
                    effect: ScrollingDotsEffect(
                      strokeWidth: 2,
                      activeDotColor: const Color(0xFF2294B1),
                      dotColor: const Color(0xFF565656).withAlpha(40),
                      maxVisibleDots: 9,
                      activeDotScale: 1.5,
                      dotHeight: 6,
                      dotWidth: 6,
                      fixedCenter: false,
                      spacing: 5,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .085,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
