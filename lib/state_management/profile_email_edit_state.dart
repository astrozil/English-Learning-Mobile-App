// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/user_data_controller.dart';

import 'package:intern_project/firebase_service/firebase_edit_service.dart';

class ProfileEmailEditStateController extends GetxController {
  static ProfileEmailEditStateController get to => Get.find();

  Rx<ProfileEmailEditState> profileEmailEditState = ProfileEmailEditState().obs;
  FirebaseEditService firebaseEditService = Get.put(FirebaseEditService());
  User? user = FirebaseAuth.instance.currentUser;
  UserDataController userDataController = Get.find();

  Future<void> profileEmailEdit(
      {required String oldEmail,
      required String newEmail,
      required String password}) async {
    profileEmailEditState.value = ProfileEmailEditLoadingState();
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: oldEmail, password: password);
      await user?.reauthenticateWithCredential(credential);

      // ignore: deprecated_member_use
      await user?.updateEmail(newEmail);

      userDataController.userDataMap["email"] = newEmail;
      try {
        await firebaseEditService.userDataEdit(key: "email", value: newEmail);
      } on TimeoutException {
        profileEmailEditState.value = ProfileEmailEditFailState();
      } catch (e) {
        profileEmailEditState.value = ProfileEmailEditFailState();
      }
      profileEmailEditState.value = ProfileEmailEditSuccessState();
    } on TimeoutException {
      profileEmailEditState.value = ProfileEmailEditFailState();
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-mismatch" ||
          e.code == "user-not-found" ||
          e.code == "invalid-credential" ||
          e.code == "wrong-password" ||
          e.code == "invalid-email" ||
          e.code == "email-already-in-use") {
        profileEmailEditState.value = ProfileEmailPasswordIncorrectState();
      }
    } catch (e) {
      profileEmailEditState.value = ProfileEmailEditFailState();
    }
  }
}

class ProfileEmailEditState {}

class ProfileEmailEditLoadingState extends ProfileEmailEditState {}

class ProfileEmailEditSuccessState extends ProfileEmailEditState {}

class ProfileEmailPasswordIncorrectState extends ProfileEmailEditState {}

class ProfileEmailEditFailState extends ProfileEmailEditState {}
