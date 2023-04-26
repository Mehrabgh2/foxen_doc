import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jovial_svg/jovial_svg.dart';

class CustomSvgWidget extends StatelessWidget {
  final String path;
  final Color? color;
  final bool isFullSvg;
  final BoxFit fit;

  const CustomSvgWidget(
    this.path, {
    this.color,
    this.isFullSvg = false,
    this.fit = BoxFit.fitWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isFullSvg
        ? ScalableImageWidget.fromSISource(
            alignment: Alignment.center,
            fit: fit,
            si: ScalableImageSource.fromSvg(
              DefaultAssetBundle.of(context),
              path,
              currentColor: color,
            ),
          )
        : SvgPicture.asset(
            path,
            color: color,
            fit: fit,
          );
  }
}
