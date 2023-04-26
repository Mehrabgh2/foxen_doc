import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../widget/overlay_toast.dart';

class CarSettingSmsCommandRow extends StatelessWidget {
  const CarSettingSmsCommandRow({
    required this.command,
    required this.title,
    required this.onCopy,
    required this.onSend,
    super.key,
  });

  final String command;
  final String title;
  final VoidCallback onCopy;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * .02,
        horizontal: size.width * .02,
      ),
      child: Row(
        children: [
          Expanded(
            child: DottedBorder(
              radius: const Radius.circular(10),
              borderType: BorderType.RRect,
              color: const Color(0xFF32769E),
              strokeWidth: 1,
              dashPattern: const [6, 3.5],
              padding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        command,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'YekanBakh-Regular',
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF565656),
                          fontSize: size.width * .025,
                        ),
                      ),
                    ),
                    Material(
                      color: const Color(0xFFBEE9E7),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: onCopy,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * .0135,
                            horizontal: size.width * .02,
                          ),
                          child: Center(
                            child: Text(
                              'کپی کردن',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'YekanBakh-Regular',
                                color: const Color(0xFF189A93),
                                fontSize: size.width * .025,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'YekanBakh-Regular',
                    color: const Color(0xFF565656),
                    fontSize: size.width * .025,
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                InkWell(
                  onTap: onSend,
                  child: Text(
                    'ارسال فوری پیامک',
                    style: TextStyle(
                      fontFamily: 'YekanBakh-Regular',
                      color: const Color(0xFF189A93),
                      decoration: TextDecoration.underline,
                      fontSize: size.width * .025,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
