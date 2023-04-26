import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foxenapp/modules/map/widget/map_toggle_widget.dart';
import 'package:foxenapp/modules/profile/screen/profile_screen.dart';
import 'package:foxenapp/modules/support/screen/support_screen.dart';
import 'package:get/get.dart';
import '../controller/constants_prefrences_controller.dart';
import '../controller/device_controller.dart';
import '../modules/bottom_navigation/controller/bottom_navigation_controller.dart';
import '../modules/bottom_navigation/widget/custom_bottom_navigation.dart';
import '../modules/car/screen/car_screen.dart';
import '../modules/car_list/screen/car_list_screen.dart';
import '../modules/map/controller/custom_map_controller.dart';
import '../modules/map/screen/map_screen.dart';
import '../util/app_theme.dart';
import '../widget/custom_svg_widget.dart';
import '../widget/home_appbar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final ConstantsPrefrencesController constantsPrefrencesController =
      Get.find<ConstantsPrefrencesController>();
  final DeviceController deviceController = Get.find<DeviceController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    List<Widget> pages = [
      CarScreen(
        deviceController: Get.find<DeviceController>(),
        constantsPrefrencesController: constantsPrefrencesController,
      ),
      const SizedBox(),
      const SupportScreen(),
      const ProfileScreen(),
    ];
    final CustomMapController mapController = Get.find<CustomMapController>();
    const MapScreen mapScreen = MapScreen();
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: GetBuilder<BottomNavigationController>(
        init: BottomNavigationController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (controller.index.value == 1) {
                return true;
              } else {
                controller.changeIndex(1);
                mapController.showCarsArea();
                mapController.updateIsMapScreen(true);
                return false;
              }
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    HomeAppBar(
                      title: getPageTitle(controller.index.value),
                      centerWidget: controller.index.value == 1
                          ? Obx(
                              () => Row(
                                children: [
                                  Text(
                                    'فارسی',
                                    style: TextStyle(
                                      fontSize: size.width * .035,
                                      fontFamily: 'YekanBakh-Bold',
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * .025,
                                  ),
                                  MapToggleWidget(
                                    value: mapController.isGoogleMap.value,
                                    onChanged: mapController.toggleIsGoogleMap,
                                  ),
                                  SizedBox(
                                    width: size.width * .025,
                                  ),
                                  Text(
                                    'گوگل',
                                    style: TextStyle(
                                      fontSize: size.width * .035,
                                      fontFamily: 'YekanBakh-Bold',
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : null,
                      rightWidget: controller.index.value == 0
                          ? Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    () => const CarListScreen(),
                                    transition: Transition.rightToLeft,
                                  );
                                },
                                overlayColor: MaterialStateProperty.resolveWith(
                                  (states) => AppTheme.hintColor.withAlpha(50),
                                ),
                                borderRadius: BorderRadius.circular(100.0),
                                child: Container(
                                  height: HomeAppBar.height,
                                  width: HomeAppBar.height,
                                  padding: const EdgeInsets.all(18),
                                  child: const FittedBox(
                                    child: CustomSvgWidget(
                                      'assets/car/list.svg',
                                      color: Color(0xFF189A93),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : null,
                    ),
                    Expanded(
                      child: IndexedStack(
                        index: mapController.isMapScreen.value ? 0 : 1,
                        children: [
                          mapScreen,
                          pages.elementAt(controller.index.value),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomBottomNavigation(
                    controller: controller,
                    onSelected: (index) {
                      controller.changeIndex(index);
                      if (index == 1) {
                        mapController.showCarsArea();
                        mapController.updateIsMapScreen(true);
                      } else {
                        mapController.updateIsMapScreen(false);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'ماشین';
      case 1:
        return 'نقشه';
      case 2:
        return 'پشتیبانی';
      case 3:
        return 'کاربری';
      default:
        return 'خانه';
    }
  }
}
