import 'package:flutter/material.dart';
import '../controller/custom_map_controller.dart';
import '../widget/map_bound_widget.dart';
import '../widget/map_control_bottomsheet.dart';
import '../widget/map_option_widget.dart';
import '../widget/map_widget.dart';
import '../../../controller/device_controller.dart';
import 'package:get/get.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CustomMapController mapController = Get.find<CustomMapController>();
    DeviceController deviceController = Get.find<DeviceController>();
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            MapWidget(mapController: mapController),
            Positioned(
              right: 10,
              top: 10,
              child: MapOptionWidget(
                mapController: mapController,
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: MapBoundWidget(onPressed: mapController.showCarsArea),
            ),
            if (mapController.isBottomSheetOpen.value)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: MapControlBottomSheet(
                  device: deviceController.devices.value.firstWhere((element) =>
                      element.vehicleId.toString() ==
                      mapController.selectedMarker.value!.uniqueKey),
                  mapController: mapController,
                  deviceController: deviceController,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
