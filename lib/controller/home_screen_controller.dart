import 'package:get/get.dart';

import 'package:intern_project/controller/unit_list_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get to => Get.find();

  RxString getUnitState(int unit) {
    RxMap dataMap = UserDataController.to.userDataMap;
    if (dataMap["unit"] > unit) {
      return "Completed".obs;
    } else if (dataMap["unit"] == unit) {
      return "Continue".obs;
    } else {
      return "Locked".obs;
    }
  }

  RxDouble getUnitProgress() {
    RxMap dataMap = UserDataController.to.userDataMap;

    if (dataMap["lesson"] == 1 && dataMap["material"] == 0) {
      return 0.0.obs;
    } else {
      return RxDouble(((((dataMap["lesson"] - 1) * 6) + dataMap["material"]) /
          (UnitListController.to
                      .unitList[UserDataController.to.userDataMap["unit"] - 1]
                  ["lesson"] *
              6)));
    }
  }
}
