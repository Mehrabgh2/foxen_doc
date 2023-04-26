import 'package:flutter/material.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../../../widget/dialog_box.dart';

class CarSettingDeviceInfoRow extends StatelessWidget {
  const CarSettingDeviceInfoRow({
    required this.title,
    required this.value,
    this.info,
    super.key,
  });

  final String title;
  final String value;
  final String? info;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * .05,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'YekanBakh-Regular',
                color: const Color(0xFF828282),
                fontSize: size.width * .03,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (info != null)
                  InkWell(
                    onTap: () => DialogBox.showInfoDialog(
                      context: context,
                      info: info!,
                    ),
                    child: const CustomSvgWidget('assets/car/info.svg'),
                  ),
                SizedBox(
                  width: size.width * .02,
                ),
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF828282),
                    fontSize: size.width * .03,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
