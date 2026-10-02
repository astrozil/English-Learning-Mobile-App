import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_project/controller/main_screen_controller.dart';
import 'package:intern_project/controller/unit_list_controller.dart';
import 'package:intern_project/controller/user_data_controller.dart';
import 'package:intern_project/features/firebase/domain/repo/firebase_repo.dart';
import 'package:intern_project/firebase_service/firbase_get_service.dart';

class FirebaseRepoImpl implements FirebaseRepo {
  @override
  Future<void> getUnitList() async {
    await FirebaseGetService.to.getAllUnits().then((value) {
      UnitListController.to.unitList.value = value["unit"];
    });
    MainScreenController.to.ready.value = true;
  }

  @override
  Future<void> getUserData() async {
    await FirebaseGetService.to
        .getUserData(uid: FirebaseAuth.instance.currentUser!.uid)
        .then((value) async {
      UserDataController.to.userDataMap.value = value;
    });
  }
}
