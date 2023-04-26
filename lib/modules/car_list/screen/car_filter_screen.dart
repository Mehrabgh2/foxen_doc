import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/home_appbar.dart';

class CarFilterScreen extends StatefulWidget {
  const CarFilterScreen({
    required this.carFilterJustInMove,
    required this.carFilterJustAccOn,
    required this.carFilterJustSecurityOn,
    super.key,
  });

  final bool carFilterJustInMove;
  final bool carFilterJustAccOn;
  final bool carFilterJustSecurityOn;

  @override
  State<CarFilterScreen> createState() => _CarFilterScreenState();
}

class _CarFilterScreenState extends State<CarFilterScreen> {
  late bool tempCarFilterJustInMove = widget.carFilterJustInMove;
  late bool tempCarFilterJustAccOn = widget.carFilterJustAccOn;
  late bool tempCarFilterJustSecurityOn = widget.carFilterJustSecurityOn;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Get.back(
          result: [
            tempCarFilterJustInMove,
            tempCarFilterJustAccOn,
            tempCarFilterJustSecurityOn,
          ],
        );
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            HomeAppBar(
              onBack: () => Get.back(
                result: [
                  tempCarFilterJustInMove,
                  tempCarFilterJustAccOn,
                  tempCarFilterJustSecurityOn,
                ],
              ),
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
                  for (int i = 0; i < 3; i++)
                    Column(
                      children: [
                        sortItemRow(i, size),
                        SizedBox(height: size.height * .0065)
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getFilterItemTitle(int index) {
    switch (index) {
      case 0:
        return 'قفط در حال حرکت ها';
      case 1:
        return 'فقط روشن ها';
      case 2:
        return 'فقط دزدگیرهای آنلاین';
      default:
        return '';
    }
  }

  bool _getFilterItemValue(int index) {
    switch (index) {
      case 0:
        return tempCarFilterJustInMove;
      case 1:
        return tempCarFilterJustAccOn;
      case 2:
        return tempCarFilterJustSecurityOn;
      default:
        return false;
    }
  }

  Widget sortItemRow(int index, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CupertinoSwitch(
          activeColor: const Color(0xFF189A93),
          value: _getFilterItemValue(index),
          onChanged: (value) {
            updateFilter(value, index);
          },
        ),
        Text(
          _getFilterItemTitle(index),
          style: TextStyle(
            fontSize: size.width * .03,
            fontFamily: 'YekanBakh-Regular',
            color: const Color(0xFF565656),
          ),
        ),
      ],
    );
  }

  void updateFilter(bool value, int index) {
    switch (index) {
      case 0:
        tempCarFilterJustInMove = value;
        break;
      case 1:
        tempCarFilterJustAccOn = value;
        break;
      case 2:
        tempCarFilterJustSecurityOn = value;
        break;
    }
    setState(() {});
  }
}
