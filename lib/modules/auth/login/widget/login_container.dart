import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../util/app_theme.dart';

class LoginContainer extends StatelessWidget {
  final Widget child;

  const LoginContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      width: size.width,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).viewInsets.bottom == 0
            ? size.height * .7
            : size.height * .35,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .05,
        vertical: 20,
      ),
      margin: EdgeInsets.symmetric(horizontal: size.width * .05),
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
    );
  }
}
