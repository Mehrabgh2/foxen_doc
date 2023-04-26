import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class CarDontHaveSecurityContainer extends StatelessWidget {
  const CarDontHaveSecurityContainer({
    required this.onSetupSecurity,
    required this.onDontShowAgain,
    super.key,
  });

  final VoidCallback onSetupSecurity;
  final VoidCallback onDontShowAgain;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(200),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          overlayColor: MaterialStateColor.resolveWith(
            (states) => const Color(0xFF189A93).withAlpha(20),
          ),
          borderRadius: BorderRadius.circular(10),
          onTap: onSetupSecurity,
          child: BlurryContainer(
            blur: 10,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .04,
              vertical: size.height * .02,
            ),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            child: Column(
              children: [
                Text(
                  'در  حال  حاضر  سیستم دزدگیر  اینترنتی  بر  روی  ماشین  شما  نصب  نیست',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'YekanBakh-Regular',
                    color: Colors.white,
                    fontSize: size.width * .032,
                  ),
                ),
                SizedBox(
                  height: size.height * .04,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .025,
                      vertical: size.height * .0075,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'ویژگی ها و شرایط نصب',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'YekanBakh-Regular',
                            color: Colors.white,
                            fontSize: size.width * .032,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      overlayColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xFF189A93).withAlpha(20),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      onTap: onDontShowAgain,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * .025,
                          vertical: size.height * .0055,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        child: Text(
                          'عدم نمایش',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'YekanBakh-Regular',
                            color: Colors.white,
                            fontSize: size.width * .032,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
