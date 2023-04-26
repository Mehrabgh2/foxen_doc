import 'package:flutter/material.dart';

import '../../../widget/custom_svg_widget.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/dialog_box.dart';

class CarSettingInfoRow extends StatelessWidget {
  const CarSettingInfoRow({
    required this.title,
    required this.textController,
    this.info,
    this.innerHint,
    super.key,
  });

  final String title;
  final TextEditingController textController;
  final String? info;
  final String? innerHint;

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
            child: SizedBox(
              height: CustomTextField.height * 1.25,
              child: CustomTextField(
                controller: textController,
                textAlign: TextAlign.right,
                leftWidget: innerHint == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          innerHint!,
                          style: const TextStyle(
                            color: Color(0xFF979797),
                            fontSize: 12.0,
                            fontFamily: 'YekanBakh-Regular',
                          ),
                        ),
                      ),
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
