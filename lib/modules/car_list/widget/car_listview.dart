import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/device_controller.dart';
import '../../../enum/car_sort_type.dart';
import '../../../model/foxen_device.dart';
import '../../../util/app_theme.dart';
import '../../../util/device_field_extractor.dart';
import 'car_item_row.dart';

class CarListView extends StatelessWidget {
  const CarListView({
    required this.onPressed,
    required this.carSortType,
    required this.carFilterJustInMove,
    required this.carFilterJustAccOn,
    required this.carFilterJustSecurityOn,
    required this.carSearchQuery,
    super.key,
  });

  final Function(FoxenDevice) onPressed;
  final Rx<CarSortType> carSortType;
  final RxBool carFilterJustInMove;
  final RxBool carFilterJustAccOn;
  final RxBool carFilterJustSecurityOn;
  final RxString carSearchQuery;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final DeviceController deviceController = Get.find<DeviceController>();
    return Obx(() {
      List<FoxenDevice> devices = sortCars(
        searchCars(
          filterCars(deviceController),
          carSearchQuery.value,
        ),
        carSortType.value,
      );
      return devices.isEmpty
          ? Center(
              child: Text(
                'ماشینی یافت نشد',
                style: TextStyle(
                  fontSize: size.width * .0425,
                  fontFamily: 'YekanBakh-Regular',
                  color: AppTheme.shadowColor,
                ),
              ),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: EdgeInsets.symmetric(
                vertical: size.height * .02,
                horizontal: size.width * .05,
              ),
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return CarItemRow(
                  onPressed: onPressed,
                  device: devices.elementAt(index),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: size.height * .02,
                );
              },
            );
    });
  }

  List<FoxenDevice> sortCars(List<FoxenDevice> cars, CarSortType carSortType) {
    List<FoxenDevice> tempList = cars;
    switch (carSortType) {
      case CarSortType.name:
        tempList.sort(
          (a, b) {
            String aTitle = DeviceFieldExtractor.getCarName(a);
            String bTitle = DeviceFieldExtractor.getCarName(b);
            return aTitle.compareTo(bTitle);
          },
        );
        break;
      case CarSortType.highestSpeed:
        tempList.sort(
          (a, b) {
            num aSpeed = DeviceFieldExtractor.getCarSpeed(a);
            num bSpeed = DeviceFieldExtractor.getCarSpeed(b);
            return bSpeed.compareTo(aSpeed);
          },
        );
        break;
    }
    return tempList;
  }

  List<FoxenDevice> filterCars(DeviceController deviceController) {
    List<FoxenDevice> tempList = deviceController.devices.value;
    List<FoxenDevice> finalList = List.from(tempList);
    if (carFilterJustInMove.value) {
      for (var element in tempList) {
        if (DeviceFieldExtractor.getCarSpeed(element) < 3) {
          finalList.remove(element);
        }
      }
    }
    if (carFilterJustAccOn.value) {
      for (var element in tempList) {
        if (!DeviceFieldExtractor.getIsCarAccOn(element)) {
          finalList.remove(element);
        }
      }
    }
    if (carFilterJustSecurityOn.value) {
      for (var element in tempList) {
        if (!DeviceFieldExtractor.getIsSecurityOn(element)) {
          finalList.remove(element);
        }
      }
    }
    return finalList;
  }

  List<FoxenDevice> searchCars(List<FoxenDevice> cars, String query) {
    List<FoxenDevice> tempCars = [];
    for (var element in cars) {
      String title = DeviceFieldExtractor.getCarName(element);
      if (title.toLowerCase().contains(query.toLowerCase())) {
        tempCars.add(element);
      }
    }
    return tempCars;
  }
}
