import 'package:flutter/material.dart';
import '../../../util/app_theme.dart';
import '../../../widget/custom_svg_widget.dart';

class AuthSupportWidget extends StatelessWidget {
  const AuthSupportWidget({
    required this.callSupport,
    Key? key,
  }) : super(key: key);
  static const phoneIconSize = 26.0;
  final VoidCallback callSupport;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: phoneIconSize,
      child: InkWell(
        onTap: callSupport,
        child: Center(
          child: Stack(
            children: [
              Positioned(
                bottom: -4,
                left: phoneIconSize / 1.15,
                child: SizedBox(
                  width: size.width * .13,
                  child: const FittedBox(
                    child: Text(
                      '۰۲۱۵۸۴۳۱',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'YekanBakh-Bold',
                        color: AppTheme.successColor,
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 0,
                child: SizedBox(
                  width: phoneIconSize,
                  height: phoneIconSize,
                  child: CustomSvgWidget('assets/authentication/phone.svg'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
