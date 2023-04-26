import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../util/app_theme.dart';

class ForgetPasswordContainer extends StatelessWidget {
  final Widget child;

  const ForgetPasswordContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * .1),
        Container(
          width: size.width,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * .05,
            vertical: 20,
          ),
          margin: EdgeInsets.symmetric(horizontal: size.width * .05),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: AppTheme.borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.backgroundColor,
            boxShadow: const [
              BoxShadow(
                offset: Offset(1, 20),
                color: AppTheme.shadowColor,
                blurRadius: 30,
                spreadRadius: 3,
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}
