import '../box/hive_boxes.dart';
import '../../model/foxen_user.dart';

class FoxenUserDBProvider {
  static final FoxenUserDBProvider _singleton = FoxenUserDBProvider._internal();
  factory FoxenUserDBProvider() {
    return _singleton;
  }
  FoxenUserDBProvider._internal();

  FoxenUser? getFoxenUser() {
    FoxenUser? user;
    for (Map<dynamic, dynamic> element in HiveBoxes.getFoxenUserBox().values) {
      Map<String, dynamic> map = Map.fromEntries(element.entries
          .map((entry) => MapEntry(entry.key.toString(), entry.value)));
      user = FoxenUser.fromJson(map);
    }
    return user;
  }

  Future<void> setFoxenUser(FoxenUser user) async {
    await removeFoxenUser();
    await HiveBoxes.getFoxenUserBox().add(user.toJson());
  }

  Future<void> removeFoxenUser() async {
    await HiveBoxes.getFoxenUserBox().clear();
  }
}
