import 'package:flutter/material.dart';
import 'package:foxenapp/widget/home_appbar.dart';
import 'package:foxenapp/widget/overlay_toast.dart';

class MapToggleWidget extends StatefulWidget {
  const MapToggleWidget({
    required this.value,
    required this.onChanged,
    super.key,
  });
  final bool value;
  final VoidCallback onChanged;

  @override
  State<MapToggleWidget> createState() => _MapToggleWidgetState();
}

class _MapToggleWidgetState extends State<MapToggleWidget> {
  late Alignment alignment =
      widget.value ? Alignment.centerRight : Alignment.centerLeft;
  int millis = 500;
  bool isFinish = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        OverlayToast.showFailureMessage('برای تغییر نقشه دکمه را نگه دارید');
      },
      onLongPressStart: (_) {
        isFinish = false;
        setState(() {
          millis = 500;
          if (widget.value) {
            alignment = Alignment.centerLeft;
          } else {
            alignment = Alignment.centerRight;
          }
        });
      },
      onLongPressEnd: (_) {
        if (!isFinish) {
          setState(() {
            millis = 150;
            if (widget.value) {
              alignment = Alignment.centerRight;
            } else {
              alignment = Alignment.centerLeft;
            }
          });
        }
      },
      child: Container(
        width: size.width * .225,
        height: HomeAppBar.height / 1.5,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            width: 2,
            color: const Color(0xFF189A93),
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: AnimatedAlign(
          duration: Duration(milliseconds: millis),
          onEnd: () {
            if (millis == 500) {
              widget.onChanged();
              isFinish = true;
            }
          },
          alignment: alignment,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: (HomeAppBar.height / 1.5) - 8,
            height: (HomeAppBar.height / 1.5) - 8,
            decoration: BoxDecoration(
              color: const Color(0xFF189A93).withAlpha(100),
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.5,
                color: const Color(0xFF189A93),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
