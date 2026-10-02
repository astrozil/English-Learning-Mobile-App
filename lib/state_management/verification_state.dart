import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerificationStateController extends GetxController {
  static VerificationStateController get to => Get.find();
  RxInt timerSecond = 60.obs;
  late Rx<Timer> timer;

  @override
  void onInit() {
    super.onInit();
    startCounting();
  }

  void startCounting() {
    if (timerSecond.value > 0) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        timerSecond.value -= 1;
        if (timerSecond.value == 0) {
          timer.cancel();
        }
      }).obs;
    }
  }

  RxBool isVerify = false.obs;
  Rx<VerificationInitialState> verificationInitialState =
      VerificationInitialState().obs;
  Future<void> verify() async {
    User? user = FirebaseAuth.instance.currentUser;

    verificationInitialState.value = VerificationLoadingState();
    if (user!.emailVerified) {
      verificationInitialState.value = VerficationSuccessState();
    }
  }
}

class VerificationInitialState {}

class VerificationLoadingState extends VerificationInitialState {}

class VerficationSuccessState extends VerificationInitialState {}
