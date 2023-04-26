import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../widget/custom_text_field.dart';
import '../../../widget/home_appbar.dart';
import '../controller/add_car_controller.dart';

class AddCarScreen extends StatelessWidget {
  const AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddCarController addCarController = Get.put(AddCarController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          HomeAppBar(
            title: 'افزودن ماشین',
            onBack: Get.back,
          ),
          Obx(
            () => Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * .02,
                        horizontal: size.width * .04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(125),
                            spreadRadius: -2,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: size.height * .06,
                            width: size.width,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: size.height * .0475,
                                    width: size.width * .5,
                                    child: CustomTextField(
                                      controller:
                                          addCarController.nameController,
                                      isError: addCarController.nameError.value,
                                    ),
                                  ),
                                  Text(
                                    'نام ماشین',
                                    style: TextStyle(
                                      fontSize: size.width * .03,
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * .06,
                            width: size.width,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: size.height * .0475,
                                    width: size.width * .5,
                                    child: CustomTextField(
                                      controller:
                                          addCarController.serialController,
                                      isError:
                                          addCarController.serialError.value,
                                    ),
                                  ),
                                  Text(
                                    'شماره سریال',
                                    style: TextStyle(
                                      fontSize: size.width * .03,
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * .06,
                            width: size.width,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: size.height * .0475,
                                    width: size.width * .5,
                                    child: CustomTextField(
                                      controller:
                                          addCarController.warrantyController,
                                      isError:
                                          addCarController.warrantyError.value,
                                    ),
                                  ),
                                  Text(
                                    'کد گارانتی',
                                    style: TextStyle(
                                      fontSize: size.width * .03,
                                      fontFamily: 'YekanBakh-Regular',
                                      color: const Color(0xFF565656),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFFF9EBEC),
                            child: InkWell(
                              onTap: Get.back,
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                height: size.height * .055,
                                child: Center(
                                  child: Text(
                                    'انصراف',
                                    style: TextStyle(
                                      fontSize: size.width * .035,
                                      fontFamily: 'YekanBakh-Bold',
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFF85763),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * .055,
                        ),
                        Expanded(
                          child: addCarController.isAddLoading.value
                              ? const SpinKitFadingCircle(
                                  color: Colors.blue,
                                )
                              : Material(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xFF84C31E),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: addCarController.addCar,
                                    child: SizedBox(
                                      height: size.height * .05,
                                      child: Center(
                                        child: Text(
                                          'ثبت',
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
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
