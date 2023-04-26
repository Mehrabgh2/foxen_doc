import 'package:flutter/material.dart';
import '../../../util/app_theme.dart';
import '../../../widget/custom_svg_widget.dart';

enum AuthType { login, signup, forget }

class AuthScreen extends StatelessWidget {
  static const wheelOpacity = .075;
  static const wheelWidth = 40.0;
  static const wheelSpace = 15.0;
  static const rowSpace = 10.0;
  static const citySvgRatio = 0.7055555556;
  static const cityTopPadding = 30.0;
  final AuthType authType;
  final Widget child;

  const AuthScreen({
    required this.authType,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _wheelColumn(context),
          authType != AuthType.forget
              ? _bottomPicture(context)
              : _bottomShadow(context),
          child,
        ],
      ),
    );
  }

  Widget _bottomPicture(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(top: cityTopPadding * 8),
        width: size.width,
        height: (size.width * citySvgRatio) + cityTopPadding * 8,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [.75, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppTheme.backgroundColor,
              AppTheme.backgroundColor.withOpacity(.2),
            ],
          ),
        ),
        child: CustomSvgWidget(
          authType == AuthType.login
              ? 'assets/authentication/login_city.svg'
              : 'assets/authentication/signup_city.svg',
          fit: BoxFit.contain,
          isFullSvg: true,
        ),
      ),
    );
  }

  Widget _bottomShadow(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(top: cityTopPadding),
        width: size.width,
        height: (size.width * citySvgRatio) + cityTopPadding * 10,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [.75, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppTheme.backgroundColor,
              AppTheme.backgroundColor.withOpacity(.2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _wheelColumn(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int count = getWheelCount(size.height);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < count; i++)
          i.isOdd
              ? SizedBox(
                  width: size.width,
                  height: wheelWidth + rowSpace,
                  child: Stack(
                    children: [
                      Positioned(
                        left: -((wheelWidth / 2) + wheelSpace),
                        right: -((wheelWidth / 2) + wheelSpace),
                        child: _wheelRow(context, true),
                      ),
                    ],
                  ),
                )
              : _wheelRow(context)
      ],
    );
  }

  Widget _wheelRow(BuildContext context, [bool half = false]) {
    final size = MediaQuery.of(context).size;
    int count = getWheelCount(size.width);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; half ? i < count + 1 : i < count; i++)
          Column(
            children: [
              const SizedBox(
                height: rowSpace / 2,
              ),
              _wheel(),
              const SizedBox(
                height: rowSpace / 2,
              ),
            ],
          ),
      ],
    );
  }

  Widget _wheel() {
    return Row(
      children: const [
        SizedBox(
          width: wheelSpace / 2,
        ),
        SizedBox(
          width: wheelWidth,
          height: wheelWidth,
          child: Opacity(
            opacity: wheelOpacity,
            child: CustomSvgWidget('assets/authentication/wheel.svg'),
          ),
        ),
        SizedBox(
          width: wheelSpace / 2,
        ),
      ],
    );
  }

  int getWheelCount(double width) =>
      (width / (wheelWidth + wheelSpace)).floor();

  int getRowCount(double height) => (height / (wheelWidth + rowSpace)).floor();
}
