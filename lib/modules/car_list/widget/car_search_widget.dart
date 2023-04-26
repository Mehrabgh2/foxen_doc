import 'package:flutter/material.dart';
import '../../../util/app_theme.dart';
import '../../../widget/custom_svg_widget.dart';

class CarSearchWidget extends StatefulWidget {
  static const height = 35.0;
  final Function(String) onChanged;
  final String hint;

  const CarSearchWidget({
    required this.onChanged,
    this.hint = '',
    Key? key,
  }) : super(key: key);

  @override
  State<CarSearchWidget> createState() => _CarSearchWidgetState();
}

class _CarSearchWidgetState extends State<CarSearchWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.textFieldBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      height: CarSearchWidget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.right,
              onChanged: widget.onChanged,
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'NunitoSans_Regular',
                fontSize: size.width * .03,
                color: AppTheme.textFieldTextColor,
              ),
              decoration: InputDecoration(
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: CustomSvgWidget(
                    'assets/car/search_suffix.svg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                counterText: '',
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  fontFamily: "YekanBakh-Regular",
                  fontSize: size.width * .0275,
                  color: AppTheme.textFieldTextColor,
                ),
                hintText: widget.hint,
                filled: true,
                fillColor: Colors.transparent,
                hintStyle: TextStyle(
                    color: AppTheme.textFieldTextColor,
                    fontSize: size.width * .03,
                    fontFamily: "YekanBakh-Regular"),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: size.width * .02,
                  vertical: size.height * .01,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
