import 'package:get/get.dart';

class MainScreenController extends GetxController {
  static MainScreenController get to => Get.find();

  RxInt navBarIndex = RxInt(0);

  RxBool ready = false.obs;
}
