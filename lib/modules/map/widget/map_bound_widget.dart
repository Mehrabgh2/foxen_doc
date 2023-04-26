import 'package:flutter/material.dart';
import '../../../widget/custom_svg_widget.dart';

class MapBoundWidget extends StatelessWidget {
  const MapBoundWidget({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 12,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: const [
              Text(
                'دورنما',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'YekanBakh-Bold',
                  color: Color(0xFF189A93),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              CustomSvgWidget(
                'assets/map/map_bound.svg',
                color: Color(0xFF189A93),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
