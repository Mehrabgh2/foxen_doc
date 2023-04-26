import 'package:flutter/material.dart';
import 'package:foxenapp/widget/drop_down_widget.dart';

import 'custom_text_field.dart';

class PlateWidget extends StatelessWidget {
  const PlateWidget({
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
      height: CustomTextField.height * 1.25,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: CustomTextField(
              controller: first,
              type: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 2,
            ),
          ),
          SizedBox(
            width: size.width * .01,
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: CustomTextField.height,
              child: DropDownWidget(
                hint: '',
                currentValue: second,
                values: values,
                fetchingText: '',
                isFetching: false,
                onSelected: onChanged,
              ),
            ),
          ),
          SizedBox(
            width: size.width * .01,
          ),
          Expanded(
            flex: 3,
            child: CustomTextField(
              controller: third,
              type: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 3,
            ),
          ),
          SizedBox(
            width: size.width * .01,
          ),
          Expanded(
            flex: 2,
            child: CustomTextField(
              controller: fourth,
              type: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 2,
            ),
          ),
          SizedBox(
            width: size.width * .01,
          ),
        ],
      ),
    );
  }
}
