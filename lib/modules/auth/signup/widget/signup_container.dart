import 'package:flutter/cupertino.dart';

import '../../../../util/app_theme.dart';
import '../../../../widget/custom_svg_widget.dart';
import '../../controller/authentication_controller.dart';
import '../../widget/auth_appbar.dart';

class SignupContainer extends StatelessWidget {
  static const stepHeight = 53.0;
  static const stepWidth = 22.0;
  final Widget child;
  final int step;
  final AuthenticationController authenticationController;

  const SignupContainer({
    required this.child,
    required this.step,
    required this.authenticationController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AuthAppBar(
            onBack: authenticationController.previousSignupPage,
            title: 'ثبت نام',
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Column(
              children: [
                SizedBox(height: size.height * .035),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomSvgWidget(
                      getThirdStepIcon,
                      isFullSvg: true,
                      fit: BoxFit.fill,
                    ),
                    CustomSvgWidget(
                      getSecondStepIcon,
                      isFullSvg: true,
                      fit: BoxFit.fill,
                    ),
                    CustomSvgWidget(
                      getFirstStepIcon,
                      isFullSvg: true,
                      fit: BoxFit.fill,
                    )
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  width: size.width,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).viewInsets.bottom == 0
                        ? size.height * .7
                        : size.height * .4,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .05,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: AppTheme.borderColor),
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.backgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(1, 20),
                        color: AppTheme.shadowColor,
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get getFirstStepIcon => step == 0
      ? 'assets/authentication/step/raises_one.svg'
      : 'assets/authentication/step/verified_one.svg';

  String get getSecondStepIcon => step > 1
      ? 'assets/authentication/step/verified_two.svg'
      : step < 1
          ? 'assets/authentication/step/idle_two.svg'
          : 'assets/authentication/step/raises_two.svg';

  String get getThirdStepIcon => step < 2
      ? 'assets/authentication/step/idle_three.svg'
      : 'assets/authentication/step/raises_three.svg';
}
