import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../auth/widget/auth_primary_button.dart';
import '../controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.blueGrey,
        statusBarColor: Colors.blueGrey,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Obx(
          () => controller.isFingerprintError.value
              ? getFingerprintErrorWidget(context)
              : controller.isConnectionError.value
                  ? getErrorWidget(controller.getUser, context)
                  : getLoadingWidget(context),
        );
      },
    );
  }

  Widget getLoadingWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'در حال ارتباط با سرور',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: size.width * .03,
              fontFamily: 'YekanBakh-Regular',
              color: Colors.white,
            ),
          ),
          _verticalSpacer(size),
          Text(
            'لطفا کمی صبر کنید',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: size.width * .03,
              fontFamily: 'YekanBakh-Regular',
              color: Colors.white,
            ),
          ),
          _verticalSpacer(size),
          SizedBox(
            width: size.width * .15,
            height: size.width * .15,
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: size.width * .15,
            ),
          ),
        ],
      ),
    );
  }

  Widget getErrorWidget(VoidCallback onRetryPressed, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'دستگاه به اینترنت متصل نیست',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: size.width * .03,
              fontFamily: 'YekanBakh-Regular',
              color: Colors.white,
            ),
          ),
          _verticalSpacer(size),
          AuthPrimaryButton(
            text: 'تلاش مجدد',
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }

  Widget getFingerprintErrorWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'احراز هویت انجام نشد',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: size.width * .03,
              fontFamily: 'YekanBakh-Regular',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalSpacer(Size size) {
    return SizedBox(
      height: size.height * .01,
    );
  }
}
