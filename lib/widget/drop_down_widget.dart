import 'package:flutter/material.dart';
import 'package:foxenapp/util/app_theme.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    Key? key,
    required this.hint,
    required this.currentValue,
    required this.values,
    required this.fetchingText,
    required this.isFetching,
    required this.onSelected,
  }) : super(key: key);

  final String hint;
  final List<Map> values;
  final String currentValue;
  final String fetchingText;
  final Function(String) onSelected;
  final bool isFetching;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.only(
          left: size.width * .015,
          right: size.width * .03,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
          color: AppTheme.textFieldBackground,
          border: Border.all(
            color: Colors.transparent,
            width: 1.5,
          ),
        ),
        width: size.width * .8,
        height: size.height * .06,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isDense: true,
              focusColor: Colors.transparent,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_left_rounded, size: 0),
              iconSize: 25,
              iconEnabledColor: Theme.of(context).hintColor,
              iconDisabledColor: Theme.of(context).hintColor,
              dropdownColor: Colors.white,
              menuMaxHeight: 250,
              disabledHint: isFetching
                  ? Text(
                      fetchingText,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: size.width * .03,
                        fontFamily: 'YekanBakh-Regular',
                        color: const Color(0xFF565656),
                      ),
                    )
                  : null,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              hint: Text(
                hint,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: size.width * .03,
                  fontFamily: 'YekanBakh-Regular',
                  color: const Color(0xFF565656),
                ),
              ),
              value: currentValue == '' ? null : currentValue,
              items: values.isNotEmpty
                  ? values.map((value) {
                      var reck = DropdownMenuItem(
                        alignment: Alignment.center,
                        value: value['value'],
                        child: Text(
                          value['name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: size.width * .03,
                            fontFamily: 'YekanBakh-Regular',
                            color: const Color(0xFF565656),
                          ),
                        ),
                      );
                      return reck;
                    }).toList()
                  : null,
              onChanged: (val) {
                onSelected(val.toString());
              },
            ),
          ),
        ),
      ),
    );
  }
}
