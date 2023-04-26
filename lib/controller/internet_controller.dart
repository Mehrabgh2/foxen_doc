import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  RxBool connectionStatus = false.obs;
  late StreamSubscription connectionListener;

  @override
  void onInit() {
    initListener();
    updateConnectionStatus();
    super.onInit();
  }

  @override
  void onClose() {
    connectionListener.cancel();
    super.onClose();
  }

  void initListener() {
    connectionListener = Connectivity().onConnectivityChanged.listen((event) {
      setConnectionStatus(event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi);
    });
  }

  Future<bool> getConnectionStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  void updateConnectionStatus() async {
    bool newConnectionStatus = await getConnectionStatus();
    setConnectionStatus(newConnectionStatus);
  }

  void setConnectionStatus(bool status) {
    connectionStatus.value = status;
    connectionStatus.refresh();
  }
}
