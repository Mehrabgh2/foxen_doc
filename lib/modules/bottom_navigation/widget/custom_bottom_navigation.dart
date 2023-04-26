import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bottom_navigation_controller.dart';
import 'custom_bottom_navigation_item.dart';

class CustomBottomNavigation extends StatelessWidget {
  static const itemCount = 4;
  static const height = 70.0;
  final BottomNavigationController controller;
  final Function(int) onSelected;

  const CustomBottomNavigation({
    required this.controller,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Container(
        width: size.width,
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20,
              spreadRadius: -10,
            )
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              top: 0,
              left: _getLeftPosition(controller.index.value, size.width),
              duration: const Duration(milliseconds: 150),
              child: Container(
                width: size.width * CustomBottomNavigationItem.width,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFF32769E),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBottomNavigationItem(
                  title: 'ماشین',
                  path: 'assets/bottombar/car.svg',
                  isEnabled: controller.index.value == 0,
                  onSelected: () => onSelected(0),
                ),
                CustomBottomNavigationItem(
                  title: 'نقشه',
                  path: 'assets/bottombar/map.svg',
                  isEnabled: controller.index.value == 1,
                  onSelected: () => onSelected(1),
                ),
                CustomBottomNavigationItem(
                  title: 'پشتیبانی',
                  path: 'assets/bottombar/notification.svg',
                  isEnabled: controller.index.value == 2,
                  onSelected: () => onSelected(2),
                ),
                CustomBottomNavigationItem(
                  title: 'کاربری',
                  path: 'assets/bottombar/more.svg',
                  isEnabled: controller.index.value == 3,
                  onSelected: () => onSelected(3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getLeftPosition(int index, double screenWidth) {
    double previusItemsWidth =
        screenWidth * (index * CustomBottomNavigationItem.width);
    double previusSpaceWidth = (index + 1) * _getRowSpace(screenWidth);
    return previusItemsWidth + previusSpaceWidth;
  }

  double _getRowSpace(double screenWidth) {
    double allItemsWidth = CustomBottomNavigationItem.width * itemCount;
    double spaceLeft = (1 - allItemsWidth).abs();
    return screenWidth * (spaceLeft / (itemCount + 1));
  }
}
