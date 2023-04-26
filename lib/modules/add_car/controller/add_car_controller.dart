import 'package:flutter/material.dart';
import 'package:foxenapp/controller/device_controller.dart';
import 'package:foxenapp/modules/map/controller/custom_map_controller.dart';
import '../../../enum/validator_enum.dart';
import '../../../model/request/add_vehicle_request.dart';
import '../../../service/car_service.dart';
import '../../../util/auth_validator.dart';
import '../../../widget/dialog_box.dart';
import '../../../widget/overlay_toast.dart';
import 'package:get/get.dart';

class AddCarController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController serialController = TextEditingController();
  final TextEditingController warrantyController = TextEditingController();
  RxBool isAddLoading = false.obs;
  RxBool nameError = false.obs;
  RxBool serialError = false.obs;
  RxBool warrantyError = false.obs;

  void addCar() async {
    if (validateAddCarInformation()) {
      setIsAddLoading(true);
      AddVehicleRequest vehicleRequest = AddVehicleRequest(
        name: nameController.text,
        serialNumber: serialController.text,
        warrantyNumber: warrantyController.text,
      );
      var checkDataEither = await CarService.addVehicle(vehicleRequest);
      checkDataEither.fold(
        (created) async {
          final DeviceController deviceController =
              Get.find<DeviceController>();
          await deviceController.addCar(
              created, Get.find<CustomMapController>());
          Get.back();
          deviceController.animateToDevice(deviceController.devices.length - 1);
          DialogBox.showCarCreatedDialog(
            context: Get.context!,
            carName: vehicleRequest.name,
          );
        },
        (error) async {
          OverlayToast.showFailureMessage(
            error.message.isNotEmpty
                ? error.message.first.toString()
                : 'عملیات با مشکل مواجه شد',
          );
        },
      );
      setIsAddLoading(false);
    }
  }

  bool validateAddCarInformation() {
    AuthValidateEnum vehicleNameValidation =
        AuthValidator.signupVehicleNameValidate(nameController.text);
    AuthValidateEnum serialValidation =
        AuthValidator.deviceSerialValidate(serialController.text);
    AuthValidateEnum warrantyValidation =
        AuthValidator.deviceWarrantyValidate(warrantyController.text);
    bool showFirstError = false;
    bool success = true;
    setNameError(false);
    setSerialError(false);
    setWarrantyError(false);
    if (vehicleNameValidation != AuthValidateEnum.success) {
      OverlayToast.showFailureMessage('نام خودرو وارد شده صحیح نمیباشد');
      showFirstError = true;
      setNameError(true);
      success = false;
    }
    if (serialValidation != AuthValidateEnum.success) {
      if (!showFirstError) {
        OverlayToast.showFailureMessage('شماره سریال وارد شده صحیح نمیباشد');
      }
      showFirstError = true;
      setSerialError(true);
      success = false;
    }
    if (warrantyValidation != AuthValidateEnum.success) {
      if (!showFirstError) {
        OverlayToast.showFailureMessage('کد گارانتی وارد شده صحیح نمیباشد');
      }
      setWarrantyError(true);
      success = false;
    }
    return success;
  }

  void setIsAddLoading(bool value) {
    isAddLoading.value = value;
    isAddLoading.refresh();
    update();
  }

  void setNameError(bool value) {
    nameError.value = value;
    nameError.refresh();
    update();
  }

  void setSerialError(bool value) {
    serialError.value = value;
    serialError.refresh();
    update();
  }

  void setWarrantyError(bool value) {
    warrantyError.value = value;
    warrantyError.refresh();
    update();
  }
}
