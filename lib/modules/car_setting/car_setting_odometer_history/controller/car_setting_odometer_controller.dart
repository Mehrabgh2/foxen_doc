import 'package:flutter/material.dart';
import '../../../../model/foxen_device.dart';
import '../../../../model/request/add_odometer_request.dart';
import '../../../../model/response/odometer_history_response.dart';
import '../../../../service/car_service.dart';
import '../../../../util/constants.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/dialog_box.dart';
import '../../../../widget/overlay_toast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CarSettingOdometerController extends GetxController {
  CarSettingOdometerController({required this.device});
  final RxBool isLoading = RxBool(false);
  final RxBool isSubmitLoading = RxBool(false);
  final RxBool isListPage = RxBool(true);
  final RxBool isOdometerError = RxBool(false);
  final TextEditingController odometerTextController = TextEditingController();
  final PagingController<int, OdometerHistory> odometerHistoryPagingController =
      PagingController(firstPageKey: 0);
  int page = 0;
  final FoxenDevice device;

  @override
  void onInit() {
    initPagingController();
    getHistories(DeviceFieldExtractor.getVehicleId(device), 1, true);
    super.onInit();
  }

  void initPagingController() {
    odometerHistoryPagingController.addPageRequestListener((pageKey) {
      getHistories(DeviceFieldExtractor.getVehicleId(device), pageKey, false);
    });
  }

  void resetPagingControllers() {
    if (odometerHistoryPagingController.itemList != null) {
      odometerHistoryPagingController.itemList!.clear();
    }
  }

  Future<void> refreshData() async {
    resetPagingControllers();
    odometerHistoryPagingController.removePageRequestListener((pageKey) {});
    initPagingController();
    page = 0;
    await getHistories(DeviceFieldExtractor.getVehicleId(device), 1, false);
  }

  Future<void> getHistories(num id, int pageKey, bool withLoading) async {
    try {
      if (withLoading) updateIsLoading(true);
      var response = await CarService.getOdometerHistory(id, page + 1);
      if (withLoading) updateIsLoading(false);
      response.fold((l) {
        page++;
        final isLastPage =
            l.odometerHistories.length < Constants.paginationLimit;
        if (isLastPage) {
          odometerHistoryPagingController.appendLastPage(l.odometerHistories);
        } else {
          final nextPageKey = pageKey + l.odometerHistories.length;
          odometerHistoryPagingController.appendPage(
              l.odometerHistories, nextPageKey.toInt());
        }
      }, (r) {
        odometerHistoryPagingController.error =
            r.message.elementAt(0).toString();
        OverlayToast.showFailureMessage(r.message.elementAt(0).toString());
      });
    } catch (error) {
      odometerHistoryPagingController.error = error;
    }
    update();
  }

  void submitOdometer() async {
    if (odometerTextController.text.isEmpty) {
      updateIsOdometerError(true);
    } else {
      DialogBox.showChangeOdometerDialog(
          DeviceFieldExtractor.getCarName(device), odometerTextController.text,
          () async {
        updateIsOdometerError(false);
        updateIsSubmitLoading(true);
        var response = await CarService.addOdometer(
          AddOdometerRequest(
            vehicleId: DeviceFieldExtractor.getVehicleId(device),
            odometer: OdometerRequest(
              setAsDefault: true,
              number: num.parse(odometerTextController.text),
            ),
          ),
        );
        response.fold((l) {
          page = 0;
          odometerHistoryPagingController.itemList!.insert(0, l);
          device.vehicle?.value.odometer = l.odometer;
          goToListPage();
        },
            (r) => OverlayToast.showFailureMessage(
                r.message.elementAt(0).toString()));
        updateIsSubmitLoading(false);
      });
    }
  }

  void goToListPage() {
    updateIsListPage(true);
  }

  void goToSetPage() {
    odometerTextController.clear();
    updateIsListPage(false);
  }

  void updateIsListPage(bool value) {
    isListPage.value = value;
    isListPage.refresh();
    update();
  }

  void updateIsOdometerError(bool value) {
    isOdometerError.value = value;
    isOdometerError.refresh();
    update();
  }

  void updateIsSubmitLoading(bool value) {
    isSubmitLoading.value = value;
    isSubmitLoading.refresh();
    update();
  }

  void updateIsLoading(bool value) {
    isLoading.value = value;
    isLoading.refresh();
    update();
  }
}
