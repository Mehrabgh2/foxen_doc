import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../model/response/notification_response.dart';
import '../../../service/car_service.dart';
import '../../../util/constants.dart';
import '../../../widget/overlay_toast.dart';

class NotificationController extends GetxController {
  final PagingController<int, NotificationModel> notificationPagingController =
      PagingController(firstPageKey: 0);
  int page = 0;
  final RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    initPagingController();
    getNotifications(1, true);
    super.onInit();
  }

  void initPagingController() {
    notificationPagingController.addPageRequestListener((pageKey) {
      getNotifications(pageKey, false);
    });
  }

  void resetPagingControllers() {
    if (notificationPagingController.itemList != null) {
      notificationPagingController.itemList!.clear();
    }
    page = 1;
  }

  Future<void> refreshData() async {
    resetPagingControllers();
    notificationPagingController.removePageRequestListener((pageKey) {});
    initPagingController();
    await getNotifications(1, false);
  }

  Future<void> getNotifications(int pageKey, bool withLoading) async {
    try {
      if (withLoading) updateIsLoading(true);
      var response = await CarService.getAllNotifications(page + 1);
      if (withLoading) updateIsLoading(false);
      response.fold((l) {
        page++;
        final isLastPage = l.notifications.length < Constants.paginationLimit;
        if (isLastPage) {
          notificationPagingController.appendLastPage(l.notifications);
        } else {
          final nextPageKey = pageKey + l.notifications.length;
          notificationPagingController.appendPage(
              l.notifications, nextPageKey.toInt());
        }
      }, (r) {
        notificationPagingController.error = r.message.elementAt(0).toString();
        OverlayToast.showFailureMessage(r.message.elementAt(0).toString());
      });
    } catch (error) {
      notificationPagingController.error = error;
    }
  }

  void updateIsLoading(bool value) {
    isLoading.value = value;
    isLoading.refresh();
    update();
  }
}
