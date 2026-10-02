import 'package:get/get.dart';

class UserDataController extends GetxController {
  static UserDataController get to => Get.find();

  RxMap userDataMap = {}.obs;
  RxInt currentLessonMark = 0.obs;
  RxString userUid = "".obs;
}
