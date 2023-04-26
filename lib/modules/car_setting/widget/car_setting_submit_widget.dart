import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CarSettingSubmitWidget extends StatelessWidget {
  const CarSettingSubmitWidget({
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * .08,
      padding: EdgeInsets.fromLTRB(
        size.width * .05,
        0,
        size.width * .05,
        0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Center(
        child: isLoading
            ? const SpinKitFadingCircle(
                color: Colors.blue,
              )
            : Material(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF84C31E),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onPressed,
                  child: SizedBox(
                    width: size.width * .35,
                    height: size.height * .05,
                    child: Center(
                      child: Text(
                        'ثبت تغییرات',
                        style: TextStyle(
                          fontSize: size.width * .035,
                          fontFamily: 'YekanBakh-Bold',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
