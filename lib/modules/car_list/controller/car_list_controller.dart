import 'package:get/get.dart';

import '../../../enum/car_sort_type.dart';

class CarListController extends GetxController {
  Rx<CarSortType> carSortType = Rx(CarSortType.name);
  RxBool carFilterJustInMove = RxBool(false);
  RxBool carFilterJustAccOn = RxBool(false);
  RxBool carFilterJustSecurityOn = RxBool(false);
  RxString carSearchQuery = RxString('');

  void updateCarSortType(CarSortType value) {
    carSortType.value = value;
    carSortType.refresh();
  }

  void updateCarFilter(List<bool> values) {
    carFilterJustInMove.value = values.elementAt(0);
    carFilterJustInMove.refresh();
    carFilterJustAccOn.value = values.elementAt(1);
    carFilterJustAccOn.refresh();
    carFilterJustSecurityOn.value = values.elementAt(2);
    carFilterJustSecurityOn.refresh();
  }

  void resetCarFilterAndSort() {
    carFilterJustInMove.value = false;
    carFilterJustInMove.refresh();
    carFilterJustAccOn.value = false;
    carFilterJustAccOn.refresh();
    carFilterJustSecurityOn.value = false;
    carFilterJustSecurityOn.refresh();
    carSortType.value = CarSortType.name;
    carSortType.refresh();
    carSearchQuery.value = '';
    carSearchQuery.refresh();
  }

  void updateCarSearchQuery(String value) {
    carSearchQuery.value = value;
    carSearchQuery.refresh();
    update();
  }
}
