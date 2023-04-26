import 'package:hive/hive.dart';

class HiveBoxes {
  static Box<Map<dynamic, dynamic>> getFoxenUserBox() =>
      Hive.box<Map<dynamic, dynamic>>("FoxenUserBox");
  static Box<Map<dynamic, dynamic>> getConstantsPrefrencesBox() =>
      Hive.box<Map<dynamic, dynamic>>("ConstantsPrefrencesBox");
}
