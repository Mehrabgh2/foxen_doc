import 'package:flutter/material.dart';

import '../../../widget/custom_svg_widget.dart';

class MapOptionCoreWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String? path;
  final String? text;
  final IconData? icon;

  const MapOptionCoreWidget({
    super.key,
    required this.onPressed,
    this.path,
    this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: path != null ? Colors.transparent : const Color(0xFF89CCC8),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 45,
          height: path != null ? 60 : 42.5,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: path != null
                    ? SizedBox(
                        height: 26,
                        child: CustomSvgWidget(
                          path!,
                          isFullSvg: true,
                          color: const Color(0xFF89CCC8),
                        ),
                      )
                    : Center(
                        child: Icon(
                          icon!,
                          color: Colors.white,
                        ),
                      ),
              ),
              if (path != null)
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      text!,
                      style: const TextStyle(
                        fontSize: 7.5,
                        fontFamily: 'YekanBakh-Regular',
                        color: Color(0xFF32769E),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
