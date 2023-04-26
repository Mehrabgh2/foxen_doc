import 'package:flutter/material.dart';
import '../../../controller/device_controller.dart';
import '../../add_car/screen/add_car_screen.dart';
import '../controller/car_list_controller.dart';
import 'car_filter_screen.dart';
import 'car_sort_screen.dart';
import '../widget/car_listview.dart';
import '../widget/car_search_widget.dart';
import '../../../widget/custom_svg_widget.dart';
import '../../../widget/home_appbar.dart';
import 'package:get/get.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CarListController carListController = Get.put(CarListController());
    final DeviceController deviceController = Get.find<DeviceController>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          HomeAppBar(
            title: 'ماشین ها',
            onBack: Get.back,
            rightWidget: Row(
              children: [
                SizedBox(
                  width: HomeAppBar.height / 1.5,
                  height: HomeAppBar.height / 1.5,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      onTap: () async {
                        carListController.updateCarSortType(await Get.to(
                          () => CarSortScreen(
                            type: carListController.carSortType.value,
                          ),
                          transition: Transition.rightToLeft,
                        ));
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CustomSvgWidget(
                          'assets/car/sort.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: HomeAppBar.height / 1.5,
                  height: HomeAppBar.height / 1.5,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      onTap: () async {
                        carListController.updateCarFilter(
                          await Get.to(
                            () => CarFilterScreen(
                              carFilterJustInMove:
                                  carListController.carFilterJustInMove.value,
                              carFilterJustAccOn:
                                  carListController.carFilterJustAccOn.value,
                              carFilterJustSecurityOn: carListController
                                  .carFilterJustSecurityOn.value,
                            ),
                            transition: Transition.rightToLeft,
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CustomSvgWidget(
                          'assets/car/filter.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Container(
                color: const Color(0xFFEEEEEE),
                height: 2,
              ),
              Container(
                height: size.height * .065,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      color: Colors.grey.withAlpha(100),
                      spreadRadius: -6,
                      blurRadius: 15,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .04,
                ),
                child: Center(
                  child: CarSearchWidget(
                    onChanged: carListController.updateCarSearchQuery,
                    hint: 'جستجوی نام ماشین',
                  ),
                ),
              ),
              Expanded(
                child: CarListView(
                  onPressed: (device) {
                    deviceController.animateToDevice(
                        deviceController.getVehicleIndex(device.id));
                    Get.back();
                  },
                  carSortType: carListController.carSortType,
                  carFilterJustInMove: carListController.carFilterJustInMove,
                  carFilterJustAccOn: carListController.carFilterJustAccOn,
                  carFilterJustSecurityOn:
                      carListController.carFilterJustSecurityOn,
                  carSearchQuery: carListController.carSearchQuery,
                ),
              ),
            ],
          )),
          Center(
            child: Material(
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => const AddCarScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
                child: Container(
                  height: size.height * .055,
                  width: size.width * .55,
                  decoration: BoxDecoration(
                    color: const Color(0xFF189A93),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF189A93).withAlpha(200),
                        spreadRadius: -2,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        width: size.width * .0175,
                      ),
                      Text(
                        'افزودن ماشین جدید',
                        style: TextStyle(
                          fontSize: size.width * .03,
                          fontFamily: 'YekanBakh-Bold',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        height: size.height * .04,
                        width: size.height * .04,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFF189A93),
                        ),
                      ),
                      SizedBox(
                        width: size.width * .0175,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .03,
          )
        ],
      ),
    );
  }
}
