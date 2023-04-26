import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../model/foxen_device.dart';
import '../../../widget/custom_svg_widget.dart';
import '../../add_car/screen/add_car_screen.dart';
import '../../add_car/widget/add_car_card_view.dart';
import 'car_card_view.dart';

class CarCarouselWidget extends StatelessWidget {
  const CarCarouselWidget({
    required this.page,
    required this.devices,
    required this.onBookmarkPressed,
    required this.onPageChanged,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final int page;
  final List<FoxenDevice> devices;
  final Function(FoxenDevice) onBookmarkPressed;
  final Function(int) onPageChanged;
  final CarouselController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const Positioned.fill(
          child: CustomSvgWidget(
            'assets/car/slider_background.svg',
            isFullSvg: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * .02),
          child: Obx(
            () => Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider.builder(
                    itemCount: devices.length + 1,
                    carouselController: controller,
                    options: CarouselOptions(
                      height: size.height * .325,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      initialPage: 0,
                      onPageChanged: (newIndex, reason) {
                        onPageChanged(newIndex);
                      },
                      scrollPhysics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return index < devices.length
                          ? CarCardView(
                              device: devices.elementAt(index),
                              onBookmarkPressed: onBookmarkPressed,
                            )
                          : AddCardCarView(
                              onPressed: () {
                                Get.to(
                                  () => const AddCarScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            );
                    },
                  ),
                  SizedBox(
                    height: size.height * .0075,
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: page,
                    count: devices.length + 1,
                    effect: ScrollingDotsEffect(
                      strokeWidth: 2,
                      activeDotColor: const Color(0xFF565656),
                      dotColor: const Color(0xFF565656).withAlpha(40),
                      maxVisibleDots: 9,
                      dotHeight: 6,
                      dotWidth: 6,
                      fixedCenter: false,
                      spacing: 5,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
