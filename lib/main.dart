import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'modules/splash/screen/splash_screen.dart';
import 'model/constants_prefrences.dart';
import 'model/foxen_user.dart';
import 'util/initial_binding.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await initORM();
  runApp(const MyApp());
}

Future<void> initORM() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FoxenUserAdapter());
  Hive.registerAdapter(ConstantsPrefrencesAdapter());
  if (!Hive.isBoxOpen('FoxenUserBox')) {
    await Hive.openBox<Map<dynamic, dynamic>>("FoxenUserBox");
  }
  if (!Hive.isBoxOpen('ConstantsPrefrencesBox')) {
    await Hive.openBox<Map<dynamic, dynamic>>("ConstantsPrefrencesBox");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: GetMaterialApp(
          initialBinding: InitialBinding(),
          home: const Scaffold(
            resizeToAvoidBottomInset: true,
            body: SplashScreen(),
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
