import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/expandable_widget.dart';
import '../controller/custom_map_controller.dart';
import 'map_option_core_widget.dart';

class MapOptionWidget extends StatelessWidget {
  final CustomMapController mapController;

  const MapOptionWidget({
    required this.mapController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Container(
        width: 55,
        decoration: BoxDecoration(
          color: const Color(0xFFEDEDE8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            _optionSpacer(size),
            MapOptionCoreWidget(
              onPressed: mapController.zoomIn,
              icon: Icons.add_rounded,
            ),
            _optionSpacer(size),
            MapOptionCoreWidget(
              onPressed: mapController.zoomOut,
              icon: Icons.remove_rounded,
            ),
            _optionSpacer(size),
            MapOptionCoreWidget(
              onPressed: mapController.toggleUserTracking,
              path: mapController.isUserTracking.value
                  ? 'assets/map/on_myloc.svg'
                  : 'assets/map/off_myloc.svg',
              text: 'مکان من',
            ),
            _optionSpacer(size),
            ExpandedableWidget(
              expand: mapController.isMenuOpen.value,
              child: Center(
                child: Column(
                  children: [
                    MapOptionCoreWidget(
                      onPressed: mapController.toggleTraffic,
                      path: mapController.isTraffic.value
                          ? 'assets/map/on_traffic.svg'
                          : 'assets/map/traffic.svg',
                      text: 'ترافیک',
                    ),
                    _optionSpacer(size),
                    MapOptionCoreWidget(
                      onPressed: mapController.toggleTheme,
                      path: mapController.isLight.value
                          ? 'assets/map/theme.svg'
                          : 'assets/map/on_theme.svg',
                      text: 'پس زمینه',
                    ),
                    _optionSpacer(size),
                    MapOptionCoreWidget(
                      onPressed: mapController.satelite,
                      path: mapController.isSatelite.value
                          ? 'assets/map/on_satelite.svg'
                          : 'assets/map/satelite.svg',
                      text: 'ماهواره',
                    ),
                    _optionSpacer(size),
                  ],
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  mapController.toggleMenu();
                },
                child: SizedBox(
                  width: 45,
                  height: 42.5,
                  child: Icon(
                    mapController.isMenuOpen.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: const Color(0xFF89CCC8),
                  ),
                ),
              ),
            ),
            _optionSpacer(size),
          ],
        ),
      ),
    );
  }

  Widget _optionSpacer(Size size) {
    return SizedBox(
      height: size.height * .007,
    );
  }
}
