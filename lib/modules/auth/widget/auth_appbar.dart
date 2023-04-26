import 'package:flutter/material.dart';

import '../../../util/app_theme.dart';
import '../../../widget/custom_svg_widget.dart';

class AuthAppBar extends StatelessWidget {
  static const height = 60.0;

  final VoidCallback onBack;
  final String title;

  const AuthAppBar({
    required this.onBack,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: height + MediaQuery.of(context).viewPadding.top,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withAlpha(50),
              blurRadius: 10,
              spreadRadius: 5),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top,
        right: 4,
        left: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              overlayColor: MaterialStateProperty.resolveWith(
                (states) => AppTheme.hintColor.withAlpha(50),
              ),
              borderRadius: BorderRadius.circular(100.0),
              onTap: onBack,
              child: Container(
                height: height,
                width: height,
                padding: const EdgeInsets.all(20),
                child: const CustomSvgWidget(
                  'assets/authentication/chevron_back.svg',
                  color: Color(0xFF189A93),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: AppTheme.textFieldTextColor,
              fontSize: size.width * .04,
              fontFamily: 'YekanBakh-Bold',
            ),
          ),
          Opacity(
            opacity: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) => AppTheme.hintColor.withAlpha(50),
                ),
                borderRadius: BorderRadius.circular(100.0),
                onTap: onBack,
                child: Container(
                  height: height,
                  width: height,
                  padding: const EdgeInsets.all(21),
                  child: const CustomSvgWidget(
                    'assets/authentication/chevron_back.svg',
                    color: AppTheme.loginTextColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
