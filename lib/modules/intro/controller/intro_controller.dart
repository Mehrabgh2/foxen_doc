import 'package:flutter/material.dart';
import '../../../controller/constants_prefrences_controller.dart';
import '../../../screen/main_screen.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  ConstantsPrefrencesController constantsPrefrencesController =
      Get.find<ConstantsPrefrencesController>();
  RxInt page = RxInt(0);

  void nextPage() {
    pageController.animateToPage(
      page.value + 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  void previusPage() {
    pageController.animateToPage(
      page.value - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  void done() {
    constantsPrefrencesController.updateIntroductionShown(true);
    Get.off(() => MainScreen());
  }

  @override
  void onInit() {
    pageController.addListener(() {
      if (pageController.positions.isNotEmpty) {
        if (pageController.page != null) {
          page.value = pageController.page!.toInt();
          page.refresh();
        }
      }
    });
    super.onInit();
  }
}
