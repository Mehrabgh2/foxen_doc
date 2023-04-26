import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:mapbox_gl/mapbox_gl.dart';
import '../controller/custom_map_controller.dart';
import 'package:get/get.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key, required this.mapController});
  final CustomMapController mapController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: mapController,
      builder: (_) {
        return Obx(
          () => Stack(
            children: [
              mapController.isGoogleMap.value
                  ? google.GoogleMap(
                      mapType: mapController.isSatelite.value
                          ? google.MapType.satellite
                          : google.MapType.normal,
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      rotateGesturesEnabled: false,
                      myLocationButtonEnabled: false,
                      minMaxZoomPreference:
                          const google.MinMaxZoomPreference(4, 19),
                      zoomGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      onMapCreated: mapController.setGoogleController,
                      onCameraIdle: mapController.onCameraIdleCallback,
                      initialCameraPosition: const google.CameraPosition(
                        target: google.LatLng(35.73278, 51.41998666666),
                        zoom: 6,
                      ),
                      onTap: (_) => mapController.onMapClick(),
                      onCameraMoveStarted: mapController.updateMarkersTimer,
                      buildingsEnabled: false,
                      trafficEnabled: mapController.isTraffic.value,
                    )
                  : MapboxMap(
                      minMaxZoomPreference: const MinMaxZoomPreference(4, 19),
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      dragEnabled: true,
                      myLocationTrackingMode: mapController.isUserTracking.value
                          ? MyLocationTrackingMode.Tracking
                          : MyLocationTrackingMode.None,
                      tiltGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                      accessToken:
                          'sk.eyJ1IjoibWVocmFiZ2hhc2FiIiwiYSI6ImNsYXFpaTF4YTFqcWMzdnVyb2FoZml0M3QifQ.AM8MFCmxyN8RSZZiqAFxCg',
                      styleString: mapController.selectedStyle.value,
                      onMapClick: (point, latlng) => mapController.onMapClick(),
                      onMapCreated: mapController.setController,
                      onCameraIdle: mapController.onCameraIdleCallback,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(35.73278, 51.41998666666),
                        zoom: 6,
                      ),
                      logoViewMargins: const Point(-1000, -1000),
                    ),
              Stack(
                children: mapController.markers,
              ),
            ],
          ),
        );
      },
    );
  }
}
