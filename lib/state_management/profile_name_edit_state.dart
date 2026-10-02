// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:async';

import 'package:get/get.dart';

import 'package:intern_project/firebase_service/firebase_edit_service.dart';

class ProfileNameEditStateController extends GetxController {
  static ProfileNameEditStateController get to => Get.find();

  Rx<ProfileNameEditState> profileNameEditState = ProfileNameEditState().obs;
  FirebaseEditService firebaseEditService = FirebaseEditService.to;

  Future<void> profileNameEdit({required String name}) async {
    profileNameEditState.value = ProfileNameEditLoadingState();
    try {
      await firebaseEditService.userDataEdit(key: "name", value: name).then(
          (value) =>
              profileNameEditState.value = ProfileNameEditSuccessState());
    } on TimeoutException {
      profileNameEditState.value = ProfileNameEditFailState();
    } catch (e) {
      profileNameEditState.value = ProfileNameEditFailState();
    }
  }
}

class ProfileNameEditState {}

class ProfileNameEditLoadingState extends ProfileNameEditState {}

class ProfileNameEditSuccessState extends ProfileNameEditState {}

class ProfileNameEditFailState extends ProfileNameEditState {}
