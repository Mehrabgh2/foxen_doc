import 'package:flutter/material.dart';
import '../../../../widget/plate_widget.dart';

class CarSettingIdentificationPlateWidget extends StatelessWidget {
  const CarSettingIdentificationPlateWidget({
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.values,
    required this.onChanged,
    super.key,
  });

  final TextEditingController first;
  final String second;
  final TextEditingController third;
  final TextEditingController fourth;
  final List<Map<String, dynamic>> values;
  final Function(String) onChanged;

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
            child: PlateWidget(
              first: first,
              second: second,
              third: third,
              fourth: fourth,
              values: values,
              onChanged: onChanged,
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: size.width * .02,
                ),
                Text(
                  'پلاک',
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
