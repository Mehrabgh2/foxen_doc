import 'package:flutter/material.dart';
import '../../../widget/custom_svg_widget.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  static const width = .135;
  final String title;
  final String path;
  final VoidCallback onSelected;
  final bool isEnabled;

  const CustomBottomNavigationItem({
    required this.title,
    required this.path,
    required this.onSelected,
    required this.isEnabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        overlayColor: MaterialStateColor.resolveWith(
          (states) => const Color(0xFF32769E).withAlpha(30),
        ),
        onTap: onSelected,
        child: Container(
          width: size.width * width,
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              SizedBox(
                height: 30,
                child: CustomSvgWidget(
                  path,
                  color: isEnabled
                      ? const Color(0xFF32769E)
                      : const Color(0xFF565656),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'YekanBakh-Bold',
                  color: isEnabled
                      ? const Color(0xFF32769E)
                      : const Color(0xFF565656),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
