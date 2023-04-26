import 'package:flutter/material.dart';
import 'package:foxenapp/enum/support_tutorial_video_type.dart';
import 'package:foxenapp/modules/support/support_tutorial_videos/controller/support_tutorial_videos_controller.dart';
import 'package:foxenapp/modules/support/support_tutorial_videos/widget/support_tutorial_videos_item.dart';
import 'package:get/get.dart';
import '../../../../widget/home_appbar.dart';

class SupportTutorialVideosScreen extends StatelessWidget {
  const SupportTutorialVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<SupportTutorialVideosController>(
        init: SupportTutorialVideosController(),
        builder: (controller) {
          return Obx(
            () => Column(
              children: [
                HomeAppBar(
                  title: 'ویدیو های آموزشی',
                  onBack: Get.back,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: size.height * .02,
                        horizontal: size.width * .035,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * .01,
                        horizontal: size.width * .035,
                      ),
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(100),
                            spreadRadius: -2,
                            blurRadius: 15,
                          )
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0;
                                i < SupportTutorialVideoType.values.length;
                                i++)
                              Column(
                                children: [
                                  SupportTutorialVideosItem(
                                    title: controller.getTitle(
                                      SupportTutorialVideoType.values
                                          .elementAt(i),
                                    ),
                                    description: controller.getDescription(
                                      SupportTutorialVideoType.values
                                          .elementAt(i),
                                    ),
                                    link: controller.getLink(
                                      SupportTutorialVideoType.values
                                          .elementAt(i),
                                    ),
                                    onPlay: () => controller.playFile(
                                        SupportTutorialVideoType.values
                                            .elementAt(i)),
                                    onDownload: () => controller.downloadFile(
                                        SupportTutorialVideoType.values
                                            .elementAt(i)),
                                    onCancelDownload: () =>
                                        controller.cancelDownload(
                                            SupportTutorialVideoType.values
                                                .elementAt(i)),
                                    downloadValue: controller
                                        .downloadValues.value
                                        .elementAt(
                                      SupportTutorialVideoType.values
                                          .elementAt(i)
                                          .index,
                                    ),
                                  ),
                                  if (i <
                                      SupportTutorialVideoType.values.length -
                                          1)
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: size.width * .025,
                                      ),
                                      color: const Color(0xFFE6E6E6),
                                      height: 1,
                                    )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
