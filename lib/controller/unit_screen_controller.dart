import 'package:get/get.dart';
import 'package:intern_project/controller/lesson_list_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/firebase_service/firbase_get_service.dart';

class UnitScreenController extends GetxController {
  static UnitScreenController get to => Get.find();
  RxBool ready = false.obs;

  @override
  void onInit() {
    super.onInit();
    FirebaseGetService.to.getAllLessons().then((value) {
      LessonListController.to.lessonList.value = value["lesson"] ?? [];

      Future.delayed(const Duration(milliseconds: 500), () {
        ready.value = true;
      });
    });
  }

  RxString getLessonState(int index) {
    RxMap userDataMap = UserDataController.to.userDataMap;
    if (userDataMap["lesson"] > index + 1) {
      return RxString("Completed");
    } else if (userDataMap["lesson"] == index + 1) {
      return RxString("Continue");
    } else {
      return RxString("Locked");
    }
  }
}
