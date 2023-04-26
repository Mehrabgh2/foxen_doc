import 'package:flutter/material.dart';

import '../util/app_theme.dart';
import 'custom_svg_widget.dart';

class HomeAppBar extends StatelessWidget {
  static const height = 60.0;

  final String title;
  final String? title2;
  final VoidCallback? onBack;
  final Widget? rightWidget;
  final Widget? centerWidget;

  const HomeAppBar({
    required this.title,
    this.title2,
    this.onBack,
    this.rightWidget,
    this.centerWidget,
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
            blurRadius: 15,
            spreadRadius: 3,
          ),
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
          Opacity(
            opacity: onBack != null ? 1 : 0,
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
                  child: const FittedBox(
                    child: CustomSvgWidget(
                      'assets/authentication/chevron_back.svg',
                      color: AppTheme.loginTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title2 != null)
                  Text(
                    title2!,
                    style: TextStyle(
                      color: AppTheme.textFieldTextColor,
                      fontSize: size.width * .04,
                      fontFamily: 'YekanBakh-Bold',
                    ),
                  ),
                centerWidget != null
                    ? centerWidget!
                    : Text(
                        ' $title ',
                        style: TextStyle(
                          color: AppTheme.textFieldTextColor,
                          fontSize: size.width * .04,
                          fontFamily: 'YekanBakh-Bold',
                        ),
                      ),
              ],
            ),
          ),
          rightWidget != null
              ? rightWidget!
              : Opacity(
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
