import 'package:flutter/material.dart';

import '../../../model/foxen_device.dart';
import '../../../util/device_field_extractor.dart';
import '../../../widget/custom_svg_widget.dart';

class CarItemRow extends StatelessWidget {
  const CarItemRow({
    required this.device,
    required this.onPressed,
    super.key,
  });

  final FoxenDevice device;
  final Function(FoxenDevice) onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => onPressed(device),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: size.height * .1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              width: 1.5,
              color: const Color(0xFFEEEEEE),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: size.width * .02,
              ),
              SizedBox(
                height: size.height * .02,
                width: size.height * .01,
                child: const CustomSvgWidget(
                  'assets/authentication/chevron_back.svg',
                  color: Color(0xFFC2C2C2),
                ),
              ),
              SizedBox(
                width: size.width * .03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DeviceFieldExtractor.getIsCarAccOn(device)
                        ? 'روشن'
                        : 'خاموش',
                    style: TextStyle(
                      color: const Color(0xFF84C31E),
                      fontSize: size.width * .0275,
                      fontFamily: 'YekanBakh-Regular',
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Text(
                    DeviceFieldExtractor.getIsSecurityOn(device)
                        ? 'دزدگیر آنلاین'
                        : 'دزدگیر آفلاین',
                    style: TextStyle(
                      color: DeviceFieldExtractor.getIsSecurityOn(device)
                          ? const Color(0xFF84C31E)
                          : Colors.red,
                      fontSize: size.width * .0275,
                      fontFamily: 'YekanBakh-Regular',
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DeviceFieldExtractor.getCarName(device),
                    style: TextStyle(
                      color: const Color(0xFF565656),
                      fontSize: size.width * .0365,
                      fontFamily: 'YekanBakh-Bold',
                    ),
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Row(
                    children: [
                      Text(
                        'پیروزی',
                        style: TextStyle(
                          color: const Color(0xFF979797),
                          fontSize: size.width * .0325,
                          fontFamily: 'YekanBakh-Regular',
                        ),
                      ),
                      SizedBox(
                        width: size.width * .01,
                      ),
                      const CustomSvgWidget('assets/car/location.svg'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: size.width * .065,
              ),
              SizedBox(
                height: size.height * .085,
                width: size.height * .085,
                child: FittedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset('assets/car/car_item.png'),
                  ),
                ),
              ),
              SizedBox(
                width: size.height * .006,
              )
            ],
          ),
        ),
      ),
    );
  }
}
