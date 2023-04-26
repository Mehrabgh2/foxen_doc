import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controller/car_setting_odometer_controller.dart';
import '../widget/car_setting_odometer_history_item.dart';
import '../../../../model/foxen_device.dart';
import '../../../../model/response/odometer_history_response.dart';
import '../../../../util/app_util.dart';
import '../../../../util/device_field_extractor.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/custom_text_field.dart';
import '../../../../widget/home_appbar.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CarSettingOdometerHistoryScreen extends StatelessWidget {
  const CarSettingOdometerHistoryScreen({
    required this.device,
    super.key,
  });
  final FoxenDevice device;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<CarSettingOdometerController>(
        init: CarSettingOdometerController(device: device),
        builder: (controller) {
          return Column(
            children: [
              HomeAppBar(
                title: 'تنظیمات',
                title2: DeviceFieldExtractor.getCarName(device),
                onBack: Get.back,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  size.width * .05,
                  size.height * .02,
                  size.width * .05,
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'تاریخچه تغییرات',
                      style: TextStyle(
                        fontSize: size.width * .035,
                        fontFamily: 'YekanBakh-Regular',
                        color: const Color(0xFF32769E),
                      ),
                    ),
                    SizedBox(
                      width: size.width * .02,
                    ),
                    const CustomSvgWidget(
                      'assets/car/car_setting_odometer_history.svg',
                    ),
                  ],
                ),
              ),
              controller.isListPage.value
                  ? Expanded(
                      child: controller.isLoading.value
                          ? const Center(
                              child: SpinKitFadingCircle(
                                color: Colors.blue,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                return await controller.refreshData();
                              },
                              child: controller.odometerHistoryPagingController
                                              .itemList !=
                                          null &&
                                      controller.odometerHistoryPagingController
                                          .itemList!.isNotEmpty
                                  ? PagedListView<int, OdometerHistory>(
                                      padding: EdgeInsets.symmetric(
                                        vertical: size.height * .015,
                                        horizontal: size.width * .05,
                                      ),
                                      physics: const BouncingScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics(),
                                      ),
                                      pagingController: controller
                                          .odometerHistoryPagingController,
                                      builderDelegate:
                                          PagedChildBuilderDelegate<
                                              OdometerHistory>(
                                        noItemsFoundIndicatorBuilder:
                                            (context) => Center(
                                          child: Text(
                                            'تاریخچه ای یافت نشد',
                                            style: TextStyle(
                                              fontSize: size.width * .04,
                                              fontFamily: 'YekanBakh-Regular',
                                              color: const Color(0xFF4F4F4F),
                                            ),
                                          ),
                                        ),
                                        newPageErrorIndicatorBuilder:
                                            (context) => Center(
                                          child: Text(
                                            'عملیات با مشکل مواجه شد',
                                            style: TextStyle(
                                              fontSize: size.width * .04,
                                              fontFamily: 'YekanBakh-Regular',
                                              color: const Color(0xFF4F4F4F),
                                            ),
                                          ),
                                        ),
                                        firstPageErrorIndicatorBuilder:
                                            (context) => Center(
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
                                            CarSettingOdometerHistoryItem(
                                          history: item,
                                        ),
                                      ),
                                    )
                                  : Stack(
                                      children: [
                                        ListView(
                                          physics: const BouncingScrollPhysics(
                                            parent:
                                                AlwaysScrollableScrollPhysics(),
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
                    )
                  : Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * .04,
                            vertical: size.height * .015,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withAlpha(140),
                                spreadRadius: -2,
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .04,
                                  vertical: size.height * .015,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'کیلومتر',
                                          style: TextStyle(
                                            fontFamily: 'YekanBakh-Regular',
                                            color: const Color(0xFF565656),
                                            fontSize: size.width * .0325,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * .01,
                                        ),
                                        Text(
                                          AppUtil.replacePersianNumber(
                                              DeviceFieldExtractor
                                                  .getCarOdometer(device)),
                                          style: TextStyle(
                                            fontFamily: 'YekanBakh-Regular',
                                            color: const Color(0xFF189A93),
                                            fontSize: size.width * .0325,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'مسافت طی شده فعلی',
                                      style: TextStyle(
                                        fontFamily: 'YekanBakh-Regular',
                                        color: const Color(0xFF565656),
                                        fontSize: size.width * .0325,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Container(
                                height: 2,
                                width: size.width,
                                color: const Color(0xFFE6E6E6),
                              ),
                              SizedBox(
                                height: size.height * .03,
                              ),
                              Text(
                                '.مقدار مورد نظر برای تنظیم مجدد را وارد کنید',
                                style: TextStyle(
                                  fontFamily: 'YekanBakh-Regular',
                                  color: const Color(0xFF565656),
                                  fontSize: size.width * .0325,
                                ),
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              SizedBox(
                                width: size.width * .5,
                                child: CustomTextField(
                                  hintText: 'کیلومتر',
                                  type: TextInputType.number,
                                  isError: controller.isOdometerError.value,
                                  controller: controller.odometerTextController,
                                ),
                              ),
                              SizedBox(
                                height: size.height * .03,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        controller.isSubmitLoading.value
                            ? const SpinKitFadingCircle(
                                color: Colors.blue,
                              )
                            : Material(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xFF84C31E),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: controller.submitOdometer,
                                  child: SizedBox(
                                    width: size.width * .35,
                                    height: size.height * .05,
                                    child: Center(
                                      child: Text(
                                        'ثبت تغییرات',
                                        style: TextStyle(
                                          fontSize: size.width * .035,
                                          fontFamily: 'YekanBakh-Bold',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
              if (controller.isListPage.value)
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * .015,
                    horizontal: size.width * .045,
                  ),
                  width: size.width,
                  height: size.height * .125,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(140),
                        spreadRadius: -2,
                        blurRadius: 15,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'مسافت طی شده',
                        style: TextStyle(
                          fontSize: size.width * .035,
                          fontFamily: 'YekanBakh-Regular',
                          color: const Color(0xFF8D8D8D),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF189A93),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: controller.goToSetPage,
                              child: Container(
                                width: size.width * .35,
                                height: size.height * .05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    'تنظیم مجدد',
                                    style: TextStyle(
                                      fontSize: size.width * .035,
                                      fontFamily: 'YekanBakh-Bold',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'کیلومتر',
                                style: TextStyle(
                                  fontSize: size.width * .035,
                                  fontFamily: 'YekanBakh-Regular',
                                  color: const Color(0xFF565656),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .01,
                              ),
                              Text(
                                AppUtil.replacePersianNumber(
                                    DeviceFieldExtractor.getCarOdometer(
                                        device)),
                                style: TextStyle(
                                  fontSize: size.width * .0425,
                                  fontFamily: 'YekanBakh-Bold',
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF189A93),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
