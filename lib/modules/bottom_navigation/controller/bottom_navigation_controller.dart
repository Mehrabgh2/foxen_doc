import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt index = 1.obs;

  changeIndex(int newIndex) {
    index.value = newIndex;
    index.refresh();
    update();
  }
}
