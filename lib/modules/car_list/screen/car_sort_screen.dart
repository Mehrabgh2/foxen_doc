import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../enum/car_sort_type.dart';
import '../../../widget/home_appbar.dart';

class CarSortScreen extends StatefulWidget {
  const CarSortScreen({
    this.type = CarSortType.name,
    super.key,
  });

  final CarSortType type;

  @override
  State<CarSortScreen> createState() => _CarSortScreenState();
}

class _CarSortScreenState extends State<CarSortScreen> {
  late CarSortType tempType = widget.type;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: tempType);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            HomeAppBar(
              onBack: () => Get.back(result: tempType),
              title: 'مرتب سازی ماشین ها',
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: size.height * .02,
                horizontal: size.width * .04,
              ),
              margin: EdgeInsets.symmetric(horizontal: size.width * .05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(125),
                    spreadRadius: -2,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'مرتب سازی بر اساس',
                    style: TextStyle(
                      fontSize: size.width * .0375,
                      fontFamily: 'YekanBakh-Bold',
                      color: const Color(0xFF565656),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  for (int i = 0; i < CarSortType.values.length; i++)
                    sortItemRow(
                      CarSortType.values.elementAt(i),
                      tempType,
                      size,
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getSortItemTitle(CarSortType tempType) {
    switch (tempType) {
      case CarSortType.name:
        return 'نام ماشین';
      case CarSortType.highestSpeed:
        return 'بیشترین سرعت';
    }
  }

  Widget sortItemRow(CarSortType type, CarSortType value, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          _getSortItemTitle(type),
          style: TextStyle(
            fontSize: size.width * .03,
            fontFamily: 'YekanBakh-Regular',
            color: const Color(0xFF565656),
          ),
        ),
        Radio<CarSortType>(
          activeColor: const Color(0xFF189A93),
          value: type,
          groupValue: tempType,
          onChanged: (CarSortType? value) {
            changeSort(type);
          },
        ),
      ],
    );
  }

  void changeSort(CarSortType type) {
    if (tempType == type) {
      tempType = CarSortType.name;
    } else {
      tempType = type;
    }
    setState(() {});
  }
}
