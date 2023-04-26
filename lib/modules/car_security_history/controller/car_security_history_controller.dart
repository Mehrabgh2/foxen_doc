import 'package:foxenapp/util/device_field_extractor.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../model/foxen_device.dart';
import '../../../service/car_service.dart';
import '../../../util/constants.dart';
import '../../../widget/overlay_toast.dart';

class CarSecurityHistoryController extends GetxController {
  CarSecurityHistoryController({required this.device});
  final PagingController<int, Security> securityHistoryPagingController =
      PagingController(firstPageKey: 0);
  RxBool isSecurityHistoryLoading = false.obs;
  final FoxenDevice device;
  int page = 0;

  @override
  void onInit() {
    updateIsSecurityHistoryLoading(true);
    getHistory(device, page);
    super.onInit();
  }

  void initPagingController() {
    securityHistoryPagingController.addPageRequestListener((pageKey) {
      getHistory(device, pageKey);
    });
  }

  void resetPagingControllers() {
    if (securityHistoryPagingController.itemList != null) {
      securityHistoryPagingController.itemList!.clear();
    }
  }

  Future<void> refreshData() async {
    securityHistoryPagingController.removePageRequestListener((pageKey) {});
    initPagingController();
    page = 0;
    await getHistory(device, page);
  }

  Future<void> getHistory(FoxenDevice device, int pageKey) async {
    try {
      var response = await CarService.getSecurityHistory(
          DeviceFieldExtractor.getVehicleId(device).toString(), page + 1);
      response.fold((l) {
        page++;
        final isLastPage =
            l.securityHistories.length < Constants.paginationLimit;
        if (isLastPage) {
          securityHistoryPagingController.appendLastPage(l.securityHistories);
        } else {
          final nextPageKey = pageKey + l.securityHistories.length;
          securityHistoryPagingController.appendPage(
              l.securityHistories, nextPageKey.toInt());
        }
      }, (r) {
        securityHistoryPagingController.error =
            r.message.elementAt(0).toString();
        OverlayToast.showFailureMessage(r.message.elementAt(0).toString());
      });
    } catch (error) {
      securityHistoryPagingController.error = error;
    }
    updateIsSecurityHistoryLoading(false);
  }

  void updateIsSecurityHistoryLoading(bool value) {
    isSecurityHistoryLoading.value = value;
    isSecurityHistoryLoading.refresh();
    update();
  }
}
