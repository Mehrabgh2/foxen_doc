import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foxenapp/modules/car_security_history/widget/car_security_history_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../controller/car_security_history_controller.dart';
import '../../../model/foxen_device.dart';
import '../../../widget/home_appbar.dart';
import 'package:get/get.dart';

class CarSecurityHistoryScreen extends StatelessWidget {
  const CarSecurityHistoryScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final CarSecurityHistoryController carSecurityHistoryController =
        Get.put(CarSecurityHistoryController(device: device));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => Column(
          children: [
            HomeAppBar(
              title: 'سوابق دزدگیر',
              onBack: Get.back,
            ),
            Expanded(
              child: carSecurityHistoryController.isSecurityHistoryLoading.value
                  ? const SpinKitFadingCircle(
                      color: Colors.blue,
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        return await carSecurityHistoryController.refreshData();
                      },
                      child: carSecurityHistoryController
                                      .securityHistoryPagingController
                                      .itemList !=
                                  null &&
                              carSecurityHistoryController
                                  .securityHistoryPagingController
                                  .itemList!
                                  .isNotEmpty
                          ? PagedListView<int, Security>(
                              padding: EdgeInsets.only(top: size.height * .01),
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              pagingController: carSecurityHistoryController
                                  .securityHistoryPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<Security>(
                                noItemsFoundIndicatorBuilder: (context) =>
                                    Center(
                                  child: Text(
                                    'تاریخچه ای یافت نشد',
                                    style: TextStyle(
                                      fontSize: size.width * .04,
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF4F4F4F),
                                    ),
                                  ),
                                ),
                                newPageErrorIndicatorBuilder: (context) =>
                                    Center(
                                  child: Text(
                                    'عملیات با مشکل مواجه شد',
                                    style: TextStyle(
                                      fontSize: size.width * .04,
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF4F4F4F),
                                    ),
                                  ),
                                ),
                                firstPageErrorIndicatorBuilder: (context) =>
                                    Center(
                                  child: Text(
                                    'عملیات با مشکل مواجه شد',
                                    style: TextStyle(
                                      fontSize: size.width * .04,
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF4F4F4F),
                                    ),
                                  ),
                                ),
                                itemBuilder: (context, item, index) =>
                                    CarSecurityHistoryItem(
                                  security: item,
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                ListView(
                                  physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'تاریخچه ای یافت نشد',
                                    style: TextStyle(
                                      fontSize: size.width * .0425,
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF4F4F4F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
