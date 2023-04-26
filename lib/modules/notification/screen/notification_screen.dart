import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../model/response/notification_response.dart';
import '../../../util/app_theme.dart';
import '../controller/notification_controller.dart';
import '../widget/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            return await controller.refreshData();
          },
          child: controller.isLoading.value
              ? const Center(
                  child: SpinKitFadingCircle(
                    color: Colors.blue,
                  ),
                )
              : controller.notificationPagingController.itemList != null &&
                      controller
                          .notificationPagingController.itemList!.isNotEmpty
                  ? PagedListView<int, NotificationModel>(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * .1,
                        horizontal: size.width * .05,
                      ),
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      pagingController: controller.notificationPagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<NotificationModel>(
                        noItemsFoundIndicatorBuilder: (context) => Center(
                          child: Text(
                            'هشداری یافت نشد',
                            style: TextStyle(
                              fontSize: size.width * .04,
                              fontFamily: 'YekanBakh-Regular',
                              color: const Color(0xFF4F4F4F),
                            ),
                          ),
                        ),
                        newPageErrorIndicatorBuilder: (context) => Center(
                          child: Text(
                            'عملیات با مشکل مواجه شد',
                            style: TextStyle(
                              fontSize: size.width * .04,
                              fontFamily: 'YekanBakh-Regular',
                              color: const Color(0xFF4F4F4F),
                            ),
                          ),
                        ),
                        firstPageErrorIndicatorBuilder: (context) => Center(
                          child: Text(
                            'عملیات با مشکل مواجه شد',
                            style: TextStyle(
                              fontSize: size.width * .04,
                              fontFamily: 'YekanBakh-Regular',
                              color: const Color(0xFF4F4F4F),
                            ),
                          ),
                        ),
                        itemBuilder: (context, item, index) => NotificationItem(
                          notification: item,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'هشداری ای یافت نشد',
                        style: TextStyle(
                          fontSize: size.width * .0425,
                          fontFamily: 'YekanBakh-Regular',
                          color: const Color(0xFF4F4F4F),
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
