import 'package:get/get.dart';

import '../db/provider/foxen_user_db_provider.dart';
import '../model/foxen_user.dart';

class FoxenUserController extends GetxController {
  Rx<FoxenUser?> user = Rx(null);
  FoxenUserDBProvider foxenUserDBProvider = FoxenUserDBProvider();
  @override
  void onInit() async {
    updateUser();
    super.onInit();
  }

  void updateUser() {
    user.value = foxenUserDBProvider.getFoxenUser();
    user.refresh();
  }

  void setUser(FoxenUser user) async {
    await foxenUserDBProvider.setFoxenUser(user);
    updateUser();
  }

  void setUserUser(FoxenUser user) async {
    if (foxenUserDBProvider.getFoxenUser() != null) {
      await foxenUserDBProvider
          .setFoxenUser(foxenUserDBProvider.getFoxenUser()!..user = user.user);
    }
    updateUser();
  }

  Future<void> setUserToken(String token) async {
    if (foxenUserDBProvider.getFoxenUser() != null) {
      await foxenUserDBProvider
          .setFoxenUser(foxenUserDBProvider.getFoxenUser()!..token = token);
    } else {
      FoxenUser tempUser = FoxenUser(
        token: token,
        user: User(
          id: 0,
          accountId: 0,
          firstname: '',
          lastname: '',
          username: '',
          email: UserProperties(name: '', isVerified: false),
          phone: UserProperties(name: '', isVerified: false),
          address: '',
          roleId: 0,
          registertimestamp: '',
        ),
      );
      await foxenUserDBProvider.setFoxenUser(tempUser);
    }
    updateUser();
  }

  void removeUser() async {
    await foxenUserDBProvider.removeFoxenUser();
    updateUser();
  }
}
