import 'package:get/get.dart';

class UnitLessonController extends GetxController {
  static UnitLessonController get to => Get.find();

  RxInt unit = 0.obs;
  RxInt lesson = 0.obs;
}
