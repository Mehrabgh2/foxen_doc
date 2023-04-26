import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class CustomMarker extends StatelessWidget {
  final String uniqueKey;
  final Point initialPosition;
  LatLng coordinate;
  final String icon;
  final String title;
  final double angle;
  final Function(CustomMarker) onMarkerTap;
  late final MarkerValuesController markerValuesController = Get.put(
    MarkerValuesController(
      position: Rx(initialPosition),
      icon: Rx(icon),
      title: Rx(title),
      angle: Rx(angle),
    ),
    tag: uniqueKey,
  );

  CustomMarker({
    required this.uniqueKey,
    required this.coordinate,
    required this.initialPosition,
    required this.icon,
    required this.title,
    required this.angle,
    required this.onMarkerTap,
  }) : super(key: Key(uniqueKey));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double iconSize = 20;
    var ratio = 1.0;
    ratio = Platform.isIOS ? 1.0 : MediaQuery.of(context).devicePixelRatio;
    return Obx(
      () {
        return Positioned(
          left: markerValuesController.position.value.x / ratio - iconSize / 2,
          top:
              (markerValuesController.position.value.y / ratio - iconSize / 2) -
                  iconSize,
          child: InkWell(
            onTap: () {
              if (!markerValuesController.isTooltipOpened.value) {
                onMarkerTap(this);
              } else {
                closeToolTip();
              }
            },
            child: JustTheTooltip(
              barrierDismissible: false,
              elevation: 16,
              controller: markerValuesController.toolTipController,
              preferredDirection: AxisDirection.up,
              isModal: true,
              triggerMode: TooltipTriggerMode.manual,
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  markerValuesController.title.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * .03,
                    fontFamily: 'YekanBakh-Bold',
                    color: const Color(0xFF8D8D8D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(
                    markerValuesController.angle.value / 360,
                  ),
                  child: Image.asset(
                    'assets/map/${markerValuesController.icon.value}.png',
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void updatePoint(Point<num> point) {
    markerValuesController.updatePosition(point);
  }

  void updateIcon(String newIcon) {
    markerValuesController.updateIcon(newIcon);
  }

  void updateAngle(double newAngle) {
    markerValuesController.updateAngle(newAngle);
  }

  void updateTitle(String newTitle) {
    markerValuesController.updateTitle(newTitle);
  }

  void openToolTip() {
    markerValuesController.openToolTip();
  }

  void closeToolTip() {
    markerValuesController.closeToolTip();
  }

  void toggleToolTip() {
    markerValuesController.toggleToolTip();
  }
}

class MarkerValuesController extends GetxController {
  MarkerValuesController({
    required this.position,
    required this.icon,
    required this.title,
    required this.angle,
  });

  Rx<Point> position;
  Rx<String> icon;
  Rx<String> title;
  Rx<double> angle;
  Rx<bool> isTooltipOpened = Rx(false);
  JustTheController toolTipController = JustTheController();

  @override
  void onInit() {
    toolTipController.addListener(() {
      if (toolTipController.value == TooltipStatus.isShowing) {
        isTooltipOpened.value = true;
        isTooltipOpened.refresh();
      } else {
        isTooltipOpened.value = false;
        isTooltipOpened.refresh();
      }
    });
    super.onInit();
  }

  void openToolTip() {
    isTooltipOpened.value = true;
    isTooltipOpened.refresh();
    toolTipController.showTooltip();
  }

  void closeToolTip() {
    isTooltipOpened.value = false;
    isTooltipOpened.refresh();
    toolTipController.hideTooltip();
  }

  void toggleToolTip() {
    if (isTooltipOpened.value) {
      closeToolTip();
    } else {
      openToolTip();
    }
  }

  void updatePosition(Point newPosition) {
    position.value = newPosition;
    position.refresh();
  }

  void updateIcon(String newIcon) {
    icon.value = newIcon;
    icon.refresh();
  }

  void updateTitle(String newTitle) {
    title.value = newTitle;
    title.refresh();
  }

  void updateAngle(double newAngle) {
    angle.value = newAngle;
    angle.refresh();
  }
}
