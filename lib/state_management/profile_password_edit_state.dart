// ignore_for_file: body_might_complete_normally_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/user_data_controller.dart';

import 'package:intern_project/firebase_service/firebase_edit_service.dart';

class ProfilePasswordEditStateController extends GetxController {
  static ProfilePasswordEditStateController get to => Get.find();
  RxBool isPasswordChanged = false.obs;
  RxBool isBlank = false.obs;
  RxBool isOffline = false.obs;
  RxBool isNewAndOldSame = false.obs;
  RxBool isPasswordNotMatch = false.obs;
  Rx<ProfilePasswordEditState> profilePasswordEditState =
      ProfilePasswordEditState().obs;
  FirebaseEditService firebaseEditService = Get.put(FirebaseEditService());
  User? user = FirebaseAuth.instance.currentUser;
  UserDataController userDataController = Get.find();

  Future<void> profilePasswordEdit(
      {required String oldPassword,
      required String newPassword,
      required String email}) async {
    profilePasswordEditState.value = ProfilePasswordEditLoadingState();
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: oldPassword);

      await user?.reauthenticateWithCredential(credential).then((value) {
        user
            ?.updatePassword(newPassword)
            .then((value) => profilePasswordEditState.value =
                ProfilePasswordEditSuccessState())
            // ignore: invalid_return_type_for_catch_error
            .catchError((e) => profilePasswordEditState.value =
                ProfilePasswordEditWeakPasswordState());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-mismatch" ||
          e.code == "user-not-found" ||
          e.code == "invalid-credential" ||
          e.code == "wrong-password") {
        profilePasswordEditState.value =
            ProfilePasswordPasswordIncorrectState();
      }
    } catch (e) {
      profilePasswordEditState.value = ProfilePasswordEditFailState();
    }
  }
}

class ProfilePasswordEditState {}

class ProfilePasswordEditLoadingState extends ProfilePasswordEditState {}

class ProfilePasswordEditSuccessState extends ProfilePasswordEditState {}

class ProfilePasswordPasswordIncorrectState extends ProfilePasswordEditState {}

class ProfilePasswordEditFailState extends ProfilePasswordEditState {}

class ProfilePasswordEditWeakPasswordState extends ProfilePasswordEditState {}
