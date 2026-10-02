import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  static ConnectivityController get to => Get.find();

  final Connectivity _connectivity = Connectivity();
  RxBool isOffline = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    _connectivity.onConnectivityChanged.listen((result) {
      updateConnectionStatus;
    });
  }

  Future<void> checkConnectivity() async {
    try {
      var result = await _connectivity.checkConnectivity();
      updateConnectionStatus(result);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateConnectionStatus(List<ConnectivityResult> result) {
    isOffline.value = result[0] == ConnectivityResult.none;
  }
}
