import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foxenapp/util/app_util.dart';
import 'package:foxenapp/util/device_field_extractor.dart';
import '../../../../service/car_service.dart';
import '../../../../widget/overlay_toast.dart';
import '../../../../model/foxen_device.dart';
import 'package:get/get.dart';

class CarSettingIdentificationController extends GetxController {
  CarSettingIdentificationController({required this.device});
  final FoxenDevice device;
  late Identification identification =
      device.vehicle?.value.identification ?? Identification();
  late Classification classification =
      device.vehicle?.value.classification ?? Classification();

  late TextEditingController nameController =
      TextEditingController(text: identification.name);
  late TextEditingController firstPlateController =
      TextEditingController(text: identification.plate?.first);
  late RxString secondPlate = RxString('');
  late RxString secondPlateName = RxString(identification.plate?.second ?? '');
  late TextEditingController thirdPlateController =
      TextEditingController(text: identification.plate?.third);
  late TextEditingController fourthPlateController =
      TextEditingController(text: identification.plate?.fourth);
  late TextEditingController vinController =
      TextEditingController(text: identification.vin);
  late TextEditingController typeController =
      TextEditingController(text: identification.type);
  late TextEditingController yearController =
      TextEditingController(text: identification.year);
  late TextEditingController companyController =
      TextEditingController(text: identification.made);
  late TextEditingController modelController =
      TextEditingController(text: identification.model);
  late TextEditingController bodyTypeController =
      TextEditingController(text: identification.bodyType);
  late TextEditingController chassisController =
      TextEditingController(text: identification.chassis);
  late TextEditingController groupController =
      TextEditingController(text: classification.group);
  late TextEditingController driverController =
      TextEditingController(text: classification.driverId);
  RxList<Map<String, dynamic>> persianAlphabets = RxList([]);

  RxBool isSubmitLoading = false.obs;

  @override
  void onInit() {
    getAlphabets();
    super.onInit();
  }

  void submitVehicleIdentification() async {
    setNewIdentification();
    setNewClassification();
    updateIsSubmitLoading(true);
    var updateIdentificationResponse =
        await CarService.setVehicleIdentification(
      DeviceFieldExtractor.getVehicleId(device),
      identification,
    );
    var updateClassificationResponse =
        await CarService.setVehicleClassification(
      DeviceFieldExtractor.getVehicleId(device),
      classification,
    );
    updateIsSubmitLoading(false);
    if (updateIdentificationResponse.isLeft() &&
        updateClassificationResponse.isLeft()) {
      Get.back();
      return;
    }
    if (!updateIdentificationResponse.isLeft() &&
        !updateClassificationResponse.isLeft()) {
      updateIdentificationResponse.fold(
        (l) => null,
        (r) => OverlayToast.showFailureMessage(r.message.first.message),
      );
      return;
    }
    updateIdentificationResponse.fold(
      (l) => null,
      (r) => OverlayToast.showFailureMessage(r.message.first.message),
    );
    updateClassificationResponse.fold(
      (l) => null,
      (r) => OverlayToast.showFailureMessage(r.message.first.message),
    );
  }

  void updateIsSubmitLoading(bool value) {
    isSubmitLoading.value = value;
    isSubmitLoading.refresh();
    update();
  }

  void updateSecondPlate(String value) {
    Map<String, dynamic>? selected = persianAlphabets.value.firstWhereOrNull(
        (element) => element['value'].toString() == value.toString());
    secondPlate.value = value;
    secondPlateName.value = selected != null ? selected['name'] : '';
    secondPlate.refresh();
    secondPlateName.refresh();
    update();
  }

  void getAlphabets() async {
    persianAlphabets.value = List<Map<String, dynamic>>.from(jsonDecode(
        await AppUtil.readJsonAssets('assets/json/persian_alphabet.json')));
    persianAlphabets.refresh();
    update();
    setPlate();
  }

  void setPlate() {
    Map<String, dynamic>? currentPlate = persianAlphabets.value
        .firstWhereOrNull((element) =>
            element['name'].toString() == secondPlateName.toString());
    secondPlate.value = currentPlate != null ? currentPlate['value'] : '';
    secondPlate.refresh();
    update();
  }

  void setNewIdentification() {
    identification.name = nameController.text;
    identification.vin = vinController.text;
    identification.type = typeController.text;
    identification.year = yearController.text;
    identification.model = modelController.text;
    identification.bodyType = bodyTypeController.text;
    identification.chassis = chassisController.text;
    identification.plate?.first = firstPlateController.text;
    identification.plate?.second = secondPlateName.value;
    identification.plate?.third = thirdPlateController.text;
    identification.plate?.fourth = fourthPlateController.text;
  }

  void setNewClassification() {
    classification.group = groupController.text;
    classification.driverId = driverController.text;
  }
}
