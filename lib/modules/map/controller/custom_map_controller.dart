import 'dart:async';
import 'dart:math';
import 'package:foxenapp/controller/constants_prefrences_controller.dart';
import 'package:foxenapp/modules/map/widget/custom_marker.dart';
import '../../../util/device_field_extractor.dart';
import '../../../enum/map_styles.dart';
import '../../../model/foxen_device.dart';
import '../../../util/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:permission_handler/permission_handler.dart';

class CustomMapController extends GetxController {
  ConstantsPrefrencesController constantsPrefrencesController =
      Get.find<ConstantsPrefrencesController>();
  bool locationPermissionGranted = false;
  MapboxMapController? mapController;
  google.GoogleMapController? googleMapController;
  RxString selectedStyle = Constants.LIGHT_MAPBOX_STYLE.obs;
  RxBool isGoogleMap = false.obs;
  RxBool isUserTracking = false.obs;
  RxBool isTraffic = false.obs;
  RxBool isLight = true.obs;
  RxBool isSatelite = false.obs;
  RxBool isMenuOpen = false.obs;
  RxBool isBottomSheetOpen = false.obs;
  RxBool isMapScreen = true.obs;
  Rx<CustomMarker?> selectedMarker = Rx(null);
  RxList<CustomMarker> markers = RxList([]);
  Timer? timer;

  @override
  void onInit() {
    getIsGoogleMap();
    super.onInit();
  }

  void setup() async {
    locationPermissionGranted = await getLocationPermission();
  }

  void updateIsMapScreen(bool value) {
    isMapScreen.value = value;
    isMapScreen.refresh();
    update();
  }

  void onMapClick() {
    _clearAllMarkerInfo();
    setSelectedMarker(null);
    updateIsBottomSheetOpen(false);
  }

  void setSelectedMarker(CustomMarker? newMarker) {
    selectedMarker.value = newMarker;
    selectedMarker.refresh();
  }

  Future<void> addCarToMap(FoxenDevice device, bool isLastOne) async {
    if (!markers.value.any((element) =>
        element.uniqueKey ==
        DeviceFieldExtractor.getVehicleId(device).toString())) {
      if (device.lastDeviceStatus != null &&
          device.lastDeviceStatus!.track != null &&
          device.lastDeviceStatus!.track!.value.gps != null &&
          device.lastDeviceStatus!.track!.value.gps!.loc != null &&
          device.lastDeviceStatus!.track!.value.gps!.loc!.coordinates != null &&
          device.lastDeviceStatus!.track!.value.gps!.loc!.coordinates!.length >
              1) {
        markers.value.add(
          CustomMarker(
            uniqueKey: DeviceFieldExtractor.getVehicleId(device).toString(),
            coordinate: LatLng(
                device.lastDeviceStatus!.track!.value.gps!.loc!.coordinates!
                    .elementAt(1)
                    .toDouble(),
                device.lastDeviceStatus!.track!.value.gps!.loc!.coordinates!
                    .elementAt(0)
                    .toDouble()),
            initialPosition: const Point(0, 0),
            icon: DeviceFieldExtractor.getCarIcon(
              device.lastDeviceStatus!.track != null
                  ? device.lastDeviceStatus!.track!.value
                  : null,
            ),
            title: DeviceFieldExtractor.getCarName(device),
            angle: device.lastDeviceStatus!.track != null &&
                    device.lastDeviceStatus!.track!.value.gps != null &&
                    device.lastDeviceStatus!.track!.value.gps!.heading != null
                ? device.lastDeviceStatus!.track!.value.gps!.heading!.toDouble()
                : 0,
            onMarkerTap: onMarkerTap,
          ),
        );
      }
      markers.refresh();
      if (isLastOne) {
        markers.refresh();
        update();
        _updateMarkerPosition();
      }
    }
  }

  void updateCarTrack(num vehicleId, Track update) async {
    if (await checkControllerInitialize()) {
      CustomMarker? marker = markers.value.firstWhereOrNull(
          (element) => element.uniqueKey == vehicleId.toString());
      if (marker != null) {
        String newIcon = DeviceFieldExtractor.getCarIcon(update);
        marker.updateIcon(newIcon);
        marker.updateAngle(update.gps!.heading!.toDouble());
        marker.updateAngle(update.gps!.heading!.toDouble());
        marker.coordinate = LatLng(
          update.gps!.loc!.coordinates!.elementAt(1).toDouble(),
          update.gps!.loc!.coordinates!.elementAt(0).toDouble(),
        );
        _updateMarkerPosition();
        if (markers.value.isNotEmpty) {
          if (markers.value.length == 1) {
            animateToPositionWithoutZoom(
              LatLng(
                update.gps!.loc!.coordinates!.elementAt(1).toDouble(),
                update.gps!.loc!.coordinates!.elementAt(0).toDouble(),
              ),
            );
          } else {
            showCarsArea();
          }
        }
      }
    }
  }

  void updateCarName(num? vehicleId, String? carName) async {
    if (await checkControllerInitialize()) {
      CustomMarker? marker = markers.value.firstWhereOrNull(
          (element) => element.uniqueKey == vehicleId.toString());
      if (marker != null && carName != null) {
        marker.updateTitle(carName);
      }
    }
  }

  void _clearAllMarkerInfo() {
    for (var element in markers) {
      element.closeToolTip();
    }
  }

  void onMarkerTap(CustomMarker argument) async {
    if (await checkControllerInitialize()) {
      setSelectedMarker(argument);
      _clearAllMarkerInfo();
      animateToPositionWithoutZoom(argument.coordinate);
      updateIsBottomSheetOpen(true);
      argument.openToolTip();
    }
  }

  void updateIsBottomSheetOpen(bool value) {
    isBottomSheetOpen.value = value;
    isBottomSheetOpen.refresh();
  }

  void setController(MapboxMapController newController) {
    mapController = newController;
    mapController!.addListener(() {
      if (mapController!.isCameraMoving) {
        updateMarkersTimer();
      }
    });
    if (isSatelite.value) {
      selectStyle(
          isTraffic.value ? MapStyles.sateliteTraffic : MapStyles.satelite);
    } else {
      _resetColorizeTheme();
    }
    update();
    markers.refresh();
    showCarsArea();
  }

  void setGoogleController(google.GoogleMapController newController) {
    googleMapController = newController;
    if (!isLight.value) {
      googleMapController!.setMapStyle(Constants.DARK_GOOGLE_STYLE);
    }
    update();
    markers.refresh();
    showCarsArea();
  }

  void updateMarkersTimer() {
    timer = Timer.periodic(
        const Duration(milliseconds: 15), (timer) => _updateMarkerPosition());
  }

  void _updateMarkerPosition() async {
    if (await checkControllerInitialize()) {
      if (isGoogleMap.value) {
        for (var marker in List.from(markers.value)) {
          final point = await googleMapController!.getScreenCoordinate(
            google.LatLng(
              marker.coordinate.latitude,
              marker.coordinate.longitude,
            ),
          );
          marker.updatePoint(Point(point.x, point.y));
          markers.refresh();
          markers.refresh();
          update();
        }
      } else {
        List<LatLng> coordinates = List.empty(growable: true);
        for (final marker in markers) {
          coordinates.add(marker.coordinate);
        }
        mapController!.toScreenLocationBatch(coordinates).then((points) {
          markers.value.asMap().forEach((i, value) {
            markers.value[i].updatePoint(points[i]);
            markers.refresh();
            markers.refresh();
            update();
          });
        });
      }
    }
  }

  void onCameraIdleCallback() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  void zoomIn() async {
    if (await checkControllerInitialize()) {
      if (isGoogleMap.value) {
        googleMapController!.animateCamera(
          google.CameraUpdate.zoomIn(),
        );
      } else {
        mapController!.animateCamera(
          CameraUpdate.zoomIn(),
        );
      }
    }
  }

  void zoomOut() async {
    if (await checkControllerInitialize()) {
      if (isGoogleMap.value) {
        googleMapController!.animateCamera(
          google.CameraUpdate.zoomOut(),
        );
      } else {
        mapController!.animateCamera(
          CameraUpdate.zoomOut(),
        );
      }
    }
  }

  void showMyLocation() async {
    if (await checkControllerInitialize()) {
      Position myPosition = await Geolocator.getCurrentPosition();
      if (isGoogleMap.value) {
        animateToPosition(
          LatLng(myPosition.latitude, myPosition.longitude),
        );
      } else {
        LatLng? myLatlng = await mapController!.requestMyLocationLatLng();
        animateToPosition(
          myLatlng ?? LatLng(myPosition.latitude, myPosition.longitude),
        );
      }
    }
  }

  void showCarsArea() async {
    if (markers.value.isNotEmpty) {
      setIsUserTracking(false);
      if (await checkControllerInitialize()) {
        if (isGoogleMap.value) {
          googleMapController!.animateCamera(
            markers.value.length > 1
                ? google.CameraUpdate.newLatLngZoom(
                    _getGoogleMidPointLatLngs(), _calculateGoogleZoomLevel())
                : google.CameraUpdate.newLatLngZoom(
                    _getGoogleAllLatLngs()[0], 14.5),
          );
        } else {
          mapController!.animateCamera(
            markers.value.length > 1
                ? CameraUpdate.newLatLngZoom(
                    _getMidPointLatLngs(), _calculateZoomLevel())
                : CameraUpdate.newLatLngZoom(_getAllLatLngs()[0], 14.5),
          );
        }
      }
    }
  }

  double _calculateZoomLevel() {
    double worldWidth = 256.0;
    double worldHeight = 256.0;
    double maxZoom = 15.2;
    LatLngBounds bounds = _computeBounds()!;
    LatLng ne = bounds.northeast;
    LatLng sw = bounds.southwest;
    double latFraction = (latRad(ne.latitude) - latRad(sw.latitude)) / pi;
    double lngDiff = ne.longitude - sw.longitude;
    double lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360;
    double latZoom =
        _getDirectionalZoom(Get.height, worldWidth, latFraction).toDouble();
    double lngZoom =
        _getDirectionalZoom(Get.width, worldHeight, lngFraction).toDouble();
    return min(min(latZoom, lngZoom), maxZoom);
  }

  LatLng _getMidPointLatLngs() {
    List<LatLng> coordinates = _getAllLatLngs();
    double totalLat = 0.0;
    double totalLng = 0.0;
    int count = coordinates.length;
    for (int i = 0; i < count; i++) {
      totalLat += coordinates[i].latitude;
      totalLng += coordinates[i].longitude;
    }
    return LatLng(totalLat / count, totalLng / count);
  }

  LatLngBounds? _computeBounds() {
    List<LatLng> list = _getAllLatLngs();
    if (list.isEmpty) return null;
    var firstLatLng = list.first;
    var s = firstLatLng.latitude,
        n = firstLatLng.latitude,
        w = firstLatLng.longitude,
        e = firstLatLng.longitude;
    for (var i = 1; i < list.length; i++) {
      var latlng = list[i];
      s = min(s, latlng.latitude);
      n = max(n, latlng.latitude);
      w = min(w, latlng.longitude);
      e = max(e, latlng.longitude);
    }
    return LatLngBounds(southwest: LatLng(s, w), northeast: LatLng(n, e));
  }

  List<LatLng> _getAllLatLngs() => markers.map((e) => e.coordinate).toList();

  double _calculateGoogleZoomLevel() {
    double worldWidth = 256.0;
    double worldHeight = 256.0;
    double maxZoom = 16.2;
    google.LatLngBounds bounds = _computeGoogleBounds()!;
    google.LatLng ne = bounds.northeast;
    google.LatLng sw = bounds.southwest;
    double latFraction = (latRad(ne.latitude) - latRad(sw.latitude)) / pi;
    double lngDiff = ne.longitude - sw.longitude;
    double lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360;
    double latZoom =
        _getDirectionalZoom(Get.height, worldWidth, latFraction).toDouble();
    double lngZoom =
        _getDirectionalZoom(Get.width, worldHeight, lngFraction).toDouble();
    return min(min(latZoom, lngZoom), maxZoom);
  }

  google.LatLng _getGoogleMidPointLatLngs() {
    List<google.LatLng> coordinates = _getGoogleAllLatLngs();
    double totalLat = 0.0;
    double totalLng = 0.0;
    int count = coordinates.length;
    for (int i = 0; i < count; i++) {
      totalLat += coordinates[i].latitude;
      totalLng += coordinates[i].longitude;
    }
    return google.LatLng(totalLat / count, totalLng / count);
  }

  google.LatLngBounds? _computeGoogleBounds() {
    List<google.LatLng> list = _getGoogleAllLatLngs();
    if (list.isEmpty) return null;
    var firstLatLng = list.first;
    var s = firstLatLng.latitude,
        n = firstLatLng.latitude,
        w = firstLatLng.longitude,
        e = firstLatLng.longitude;
    for (var i = 1; i < list.length; i++) {
      var latlng = list[i];
      s = min(s, latlng.latitude);
      n = max(n, latlng.latitude);
      w = min(w, latlng.longitude);
      e = max(e, latlng.longitude);
    }
    return google.LatLngBounds(
        southwest: google.LatLng(s, w), northeast: google.LatLng(n, e));
  }

  List<google.LatLng> _getGoogleAllLatLngs() => markers
      .map((e) => google.LatLng(e.coordinate.latitude, e.coordinate.longitude))
      .toList();

  double latRad(lat) {
    var sins = sin(lat * pi / 180);
    var radX2 = log((1 + sins) / (1 - sins)) / 2;
    return max(min(radX2, pi), -pi) / 2;
  }

  int _getDirectionalZoom(mapPx, worldPx, fraction) {
    return (log(mapPx / worldPx / fraction) / ln2).floor();
  }

  void animateToPosition(LatLng latlng) async {
    if (await checkControllerInitialize()) {
      if (isGoogleMap.value) {
        googleMapController!.animateCamera(
          google.CameraUpdate.newCameraPosition(
            google.CameraPosition(
              target: google.LatLng(latlng.latitude, latlng.longitude),
              zoom: 16.2,
            ),
          ),
        );
      } else {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: latlng,
              zoom: 15.2,
            ),
          ),
        );
      }
    }
  }

  void animateToPositionWithoutZoom(LatLng latlng) async {
    if (await checkControllerInitialize()) {
      if (isGoogleMap.value) {
        googleMapController!.animateCamera(google.CameraUpdate.newLatLng(
            google.LatLng(latlng.latitude, latlng.longitude)));
      } else {
        mapController!.animateCamera(CameraUpdate.newLatLng(latlng));
      }
    }
  }

  void toggleUserTracking() async {
    if (await checkControllerInitialize()) {
      setIsUserTracking(!isUserTracking.value);
      isUserTracking.value ? showMyLocation() : showCarsArea();
    }
  }

  void toggleTheme() {
    if (isSatelite.value) {
      setIsSatelite(false);
      _resetColorizeTheme();
    } else {
      setIsLight(!isLight.value);
      if (isGoogleMap.value) {
        googleMapController!
            .setMapStyle(isLight.value ? null : Constants.DARK_GOOGLE_STYLE);
      } else {
        isLight.value ? _lightTheme() : _darkTheme();
      }
    }
  }

  void _lightTheme() =>
      selectStyle(isTraffic.value ? MapStyles.lightTraffic : MapStyles.light);

  void _darkTheme() =>
      selectStyle(isTraffic.value ? MapStyles.darkTraffic : MapStyles.dark);

  void _resetColorizeTheme() {
    if (isLight.value) {
      selectStyle(isTraffic.value ? MapStyles.lightTraffic : MapStyles.light);
    } else {
      selectStyle(isTraffic.value ? MapStyles.darkTraffic : MapStyles.dark);
    }
  }

  void toggleTraffic() {
    setIsTraffic(!isTraffic.value);
    isTraffic.value ? _onTraffic() : _offTraffic();
  }

  void _onTraffic() {
    if (isSatelite.value) {
      selectStyle(MapStyles.sateliteTraffic);
    } else {
      selectStyle(
          isLight.value ? MapStyles.lightTraffic : MapStyles.darkTraffic);
    }
  }

  void _offTraffic() {
    if (isSatelite.value) {
      selectStyle(MapStyles.satelite);
    } else {
      selectStyle(isLight.value ? MapStyles.light : MapStyles.dark);
    }
  }

  void satelite() {
    setIsSatelite(!isSatelite.value);
    isSatelite.value
        ? selectStyle(
            isTraffic.value ? MapStyles.sateliteTraffic : MapStyles.satelite,
          )
        : _resetColorizeTheme();
  }

  void selectStyle(MapStyles style) {
    switch (style) {
      case MapStyles.light:
        selectedStyle.value = Constants.LIGHT_MAPBOX_STYLE;
        break;
      case MapStyles.dark:
        selectedStyle.value = Constants.DARK_MAPBOX_STYLE;
        break;
      case MapStyles.satelite:
        selectedStyle.value = Constants.SATELITE_MAPBOX_STYLE;
        break;
      case MapStyles.lightTraffic:
        selectedStyle.value = Constants.LIGHT_TRAFFIC_MAPBOX_STYLE;
        break;
      case MapStyles.darkTraffic:
        selectedStyle.value = Constants.DARK_TRAFFIC_MAPBOX_STYLE;
        break;
      case MapStyles.sateliteTraffic:
        selectedStyle.value = Constants.SATELITE_TRAFFIC_MAPBOX_STYLE;
        break;
    }
    selectedStyle.refresh();
    update();
  }

  void setIsUserTracking(bool value) {
    isUserTracking.value = value;
    isUserTracking.refresh();
    update();
  }

  void setIsSatelite(bool value) {
    isSatelite.value = value;
    isSatelite.refresh();
    update();
  }

  void setIsTraffic(bool value) {
    isTraffic.value = value;
    isTraffic.refresh();
    update();
  }

  void setIsLight(bool value) {
    isLight.value = value;
    isLight.refresh();
    update();
  }

  void toggleMenu() {
    isMenuOpen.value = !isMenuOpen.value;
    isMenuOpen.refresh();
    update();
  }

  Future<bool> checkControllerInitialize() async {
    if (isGoogleMap.value) {
      if (googleMapController != null) {
        if (locationPermissionGranted) {
          return true;
        } else {
          return await getLocationPermission();
        }
      } else {
        return false;
      }
    } else {
      if (mapController != null) {
        if (locationPermissionGranted) {
          return true;
        } else {
          return await getLocationPermission();
        }
      } else {
        return false;
      }
    }
  }

  Future<bool> getLocationPermission() async {
    try {
      return await Permission.location.request().isGranted;
    } catch (ex) {
      return Future.value(false);
    }
  }

  void getIsGoogleMap() async {
    constantsPrefrencesController.updateConstants();
    isGoogleMap.value =
        constantsPrefrencesController.constant.value.isGoogleMap;
    isGoogleMap.refresh();
  }

  void toggleIsGoogleMap() async {
    await constantsPrefrencesController.updateIsGoogleMap(!isGoogleMap.value);
    getIsGoogleMap();
  }
}
